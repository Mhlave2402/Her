<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TripFeatureCharge extends Model
{
    use HasFactory;

    protected $fillable = [
        'trip_id',
        'feature_key',
        'amount',
        'applied_by_config_id',
        'applied_at',
    ];

    protected $casts = [
        'applied_at' => 'datetime',
    ];

    public function trip()
    {
        return $this->belongsTo(TripRequest::class, 'trip_id');
    }

    public function featureFeeConfig()
    {
        return $this->belongsTo(FeatureFeeConfig::class, 'applied_by_config_id');
    }
}
