<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DriverBehavior extends Model
{
    use HasFactory;

    protected $fillable = [
        'driver_id',
        'trip_id',
        'event_type',
        'threshold_exceeded',
        'location',
        'reported'
    ];

    public function driver()
    {
        return $this->belongsTo(User::class, 'driver_id');
    }
}
