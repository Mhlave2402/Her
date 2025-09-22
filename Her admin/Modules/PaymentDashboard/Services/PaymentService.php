<?php

namespace Modules\PaymentDashboard\Services;

use Modules\PaymentDashboard\Contracts\PaymentGateway;
use Modules\PaymentDashboard\Entities\PaymentGateway as PaymentGatewayModel;
use Illuminate\Support\Facades\Log;

class PaymentService
{
    protected $gateway;

    public function __construct(PaymentGateway $gateway)
    {
        $this->gateway = $gateway;
    }

    /**
     * Set the payment gateway to be used.
     *
     * @param string $gatewayName
     * @return self
     */
    public function setGateway(string $gatewayName): self
    {
        // Logic to resolve the gateway implementation from the container
        // For now, we'll just log it. A proper implementation would use the container.
        Log::info("Setting payment gateway to: {$gatewayName}");
        return $this;
    }

    /**
     * Process a payment.
     *
     * @param float $amount
     * @param string $token
     * @param array $options
     * @return array
     */
    public function processPayment(float $amount, string $token, array $options = []): array
    {
        try {
            $result = $this->gateway->charge($amount, $token, $options);
            // Log transaction
            Log::info('Payment processed successfully.', $result);
            return ['success' => true, 'data' => $result];
        } catch (\Exception $e) {
            Log::error('Payment processing failed: ' . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    /**
     * Save a customer's card.
     *
     * @param string $token
     * @return array
     */
    public function addCard(string $token): array
    {
        try {
            $result = $this->gateway->saveCard($token);
            // Logic to save card details to the database
            Log::info('Card saved successfully.', $result);
            return ['success' => true, 'data' => $result];
        } catch (\Exception $e) {
            Log::error('Failed to save card: ' . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
}
