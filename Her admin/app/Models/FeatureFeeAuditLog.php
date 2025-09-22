<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FeatureFeeAuditLog extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'feature_fee_config_id',
        'user_id',
        'before',
        'after',
        'changed_at',
    ];

    protected $casts = [
        'before' => 'array',
        'after' => 'array',
        'changed_at' => 'datetime',
    ];

    public function featureFeeConfig()
    {
        return $this->belongsTo(FeatureFeeConfig::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
