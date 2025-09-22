<?php

namespace Modules\PaymentDashboard\Database\factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\PaymentDashboard\Entities\PaymentGateway;

class PaymentGatewayFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = PaymentGateway::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->company,
            'test_key' => $this->faker->uuid,
            'live_key' => $this->faker->uuid,
            'status' => $this->faker->boolean,
            'priority' => $this->faker->numberBetween(1, 10),
            'mode' => $this->faker->randomElement(['test', 'live']),
        ];
    }
}
