<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FeatureFeeConfig extends Model
{
    use HasFactory;

    protected $fillable = [
        'feature_key',
        'zone_id',
        'vehicle_type',
        'pricing_model',
        'value',
        'tier_config',
        'min_fee',
        'max_fee',
        'apply_on',
        'start_at',
        'end_at',
        'is_active',
        'priority',
        'created_by',
        'updated_by',
        'payout_rule',
    ];

    protected $casts = [
        'tier_config' => 'array',
        'payout_rule' => 'array',
        'is_active' => 'boolean',
        'start_at' => 'datetime',
        'end_at' => 'datetime',
    ];

    public function zone()
    {
        return $this->belongsTo(Zone::class);
    }

    public function createdByUser()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function updatedByUser()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }
}
