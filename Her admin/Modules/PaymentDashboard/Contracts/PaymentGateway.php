<?php

namespace Modules\PaymentDashboard\Contracts;

interface PaymentGateway
{
    /**
     * Charge a card for a specific amount.
     *
     * @param float $amount
     * @param string $token
     * @param array $options
     * @return array
     */
    public function charge(float $amount, string $token, array $options = []): array;

    /**
     * Save a card for future use.
     *
     * @param string $token
     * @return array
     */
    public function saveCard(string $token): array;

    /**
     * Initiate a 3D Secure authentication.
     *
     * @param float $amount
     * @param string $token
     * @param string $callbackUrl
     * @return array
     */
    public function initiate3DS(float $amount, string $token, string $callbackUrl): array;

    /**
     * Verify a 3D Secure authentication.
     *
     * @param array $data
     * @return array
     */
    public function verify3DS(array $data): array;
}
