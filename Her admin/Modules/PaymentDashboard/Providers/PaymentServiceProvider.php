<?php

namespace Modules\PaymentDashboard\Providers;

use Illuminate\Support\ServiceProvider;
use Modules\PaymentDashboard\Contracts\PaymentGateway;
use Modules\PaymentDashboard\Services\PaymentService;
use Modules\Gateways\Services\StripeService; // Assuming Stripe is one of the gateways

class PaymentServiceProvider extends ServiceProvider
{
    /**
     * Register the service provider.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton(PaymentService::class, function ($app) {
            // This is a placeholder. In a real app, you'd have a factory
            // to resolve the correct gateway based on config or request.
            return new PaymentService($app->make(StripeService::class));
        });

        // Bind a specific implementation (e.g., Stripe) to the interface.
        // You can switch this out or use a factory for multiple gateways.
        $this->app->bind(PaymentGateway::class, StripeService::class);
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides()
    {
        return [PaymentService::class, PaymentGateway::class];
    }
}
