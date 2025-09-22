<?php

namespace Modules\PaymentDashboard\Database\Seeders;

use Illuminate\Database\Seeder;

class PaymentGatewaySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \Modules\PaymentDashboard\Entities\PaymentGateway::create([
            'name' => 'Stripe',
            'status' => true,
            'priority' => 1,
            'test_key' => 'pk_test_your_stripe_key',
            'live_key' => 'pk_live_your_stripe_key',
            'mode' => 'test',
        ]);

        \Modules\PaymentDashboard\Entities\PaymentGateway::create([
            'name' => 'Paystack',
            'status' => true,
            'priority' => 2,
            'test_key' => 'pk_test_your_paystack_key',
            'live_key' => 'pk_live_your_paystack_key',
            'mode' => 'test',
        ]);
    }
}
