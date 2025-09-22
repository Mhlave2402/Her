<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SharedTripLink extends Model
{
    use HasFactory;

    protected $fillable = [
        'trip_request_id',
        'token',
        'expires_at',
    ];

    public function tripRequest()
    {
        return $this->belongsTo(TripRequest::class);
    }
}
