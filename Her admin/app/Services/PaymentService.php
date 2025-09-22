<?php

namespace App\Services;

use App\Services\PaymentGateways\PaymentGatewayInterface;
use App\Models\PaymentGateway;
use App\Models\SavedCard;
use Illuminate\Support\Facades\DB;
use Exception;
use Illuminate\Support\Facades\Mail;
use App\Mail\PaymentConfirmation;
use App\Jobs\SendSmsNotificationJob;

class PaymentService
{
    private $activeGateway;

    public function __construct()
    {
        $this->activeGateway = $this->getActivePaymentGateway();
    }

    private function getActivePaymentGateway(): PaymentGatewayInterface
    {
        $gatewayConfig = PaymentGateway::where('is_active', true)
            ->orderBy('priority')
            ->first();

        if (!$gatewayConfig) {
            throw new Exception('No active payment gateway found');
        }

        $gatewayClass = 'App\\Services\\PaymentGateways\\' . $gatewayConfig->gateway_key;
        
        if (!class_exists($gatewayClass)) {
            throw new Exception("Gateway class {$gatewayClass} does not exist");
        }

        return new $gatewayClass();
    }

    public function processPayment(array $paymentData): array
    {
        try {
            DB::beginTransaction();
            
            if (!empty($paymentData['saved_card_id'])) {
                $savedCard = SavedCard::findOrFail($paymentData['saved_card_id']);
                $paymentData['token'] = $savedCard->token;
            }

            if ($this->activeGateway->supports3DS() && $paymentData['requires_3ds']) {
                return $this->activeGateway->initiate3DS($paymentData);
            }

            $result = $this->activeGateway->chargeCard($paymentData);
            
            if ($result['status'] === 'success') {
                if (!empty($paymentData['save_card'])) {
                    $this->saveCard($paymentData['card_data'], $paymentData['user_id']);
                }
                // Send payment confirmation email
                Mail::to($paymentData['user_email'])->send(new PaymentConfirmation($result['transaction']));

                // Send SMS notification
                $message = "Your payment of {$result['transaction']->amount} was successful. Transaction ID: {$result['transaction']->id}";
                dispatch(new SendSmsNotificationJob($paymentData['user_phone'], $message));
            }

            DB::commit();
            return $result;
        } catch (Exception $e) {
            DB::rollBack();
            return [
                'status' => 'error',
                'message' => $e->getMessage()
            ];
        }
    }

    public function saveCard(array $cardData, int $userId): array
    {
        try {
            $result = $this->activeGateway->saveCard($cardData);
            
            if ($result['status'] === 'success') {
                SavedCard::create([
                    'user_id' => $userId,
                    'token' => $result['token'],
                    'masked_card_number' => $result['masked_card_number'],
                    'expiry_month' => $cardData['expiry_month'],
                    'expiry_year' => $cardData['expiry_year'],
                    'card_type' => $result['card_type'],
                    'is_default' => $cardData['is_default'] ?? false
                ]);
            }
            
            return $result;
        } catch (Exception $e) {
            return [
                'status' => 'error',
                'message' => $e->getMessage()
            ];
        }
    }

    public function handle3dsCallback(array $callbackData): array
    {
        return $this->activeGateway->verify3DS($callbackData);
    }
}
