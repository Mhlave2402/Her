<?php

namespace Modules\PaymentDashboard\Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Modules\PaymentDashboard\Entities\PaymentGateway;
use Tests\TestCase;

class GatewayControllerTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function it_can_display_a_list_of_gateways()
    {
        PaymentGateway::factory()->count(3)->create();

        $response = $this->get(route('paymentdashboard.gateways.index'));

        $response->assertStatus(200);
        $response->assertViewHas('gateways');
    }

    /** @test */
    public function it_can_create_a_gateway()
    {
        $data = [
            'name' => 'Test Gateway',
            'test_key' => 'test_123',
            'live_key' => 'live_123',
            'status' => 1,
        ];

        $response = $this->post(route('paymentdashboard.gateways.store'), $data);

        $response->assertRedirect(route('paymentdashboard.gateways.index'));
        $this->assertDatabaseHas('payment_gateways', $data);
    }

    /** @test */
    public function it_can_update_a_gateway()
    {
        $gateway = PaymentGateway::factory()->create();

        $data = [
            'name' => 'Updated Gateway',
            'test_key' => 'updated_test_123',
            'live_key' => 'updated_live_123',
            'status' => 0,
        ];

        $response = $this->put(route('paymentdashboard.gateways.update', $gateway->id), $data);

        $response->assertRedirect(route('paymentdashboard.gateways.index'));
        $this->assertDatabaseHas('payment_gateways', $data);
    }

    /** @test */
    public function it_can_delete_a_gateway()
    {
        $gateway = PaymentGateway::factory()->create();

        $response = $this->delete(route('paymentdashboard.gateways.destroy', $gateway->id));

        $response->assertRedirect(route('paymentdashboard.gateways.index'));
        $this->assertDatabaseMissing('payment_gateways', ['id' => $gateway->id]);
    }
}
