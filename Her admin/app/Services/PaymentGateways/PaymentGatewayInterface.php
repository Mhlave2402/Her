<?php

namespace App\Services\PaymentGateways;

interface PaymentGatewayInterface
{
    public function chargeCard(array $paymentData): array;
    public function saveCard(array $cardData): array;
    public function initiate3DS(array $paymentData): array;
    public function verify3DS(array $verificationData): array;
    public function getName(): string;
    public function isActive(): bool;
    public function supports3DS(): bool;
}
