<?php

namespace Modules\PaymentDashboard\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\PaymentDashboard\Database\factories\PaymentGatewayFactory;

class PaymentGateway extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'name',
        'test_key',
        'live_key',
        'status',
        'priority',
        'mode',
    ];
    
    protected static function newFactory(): PaymentGatewayFactory
    {
        return PaymentGatewayFactory::new();
    }
}
