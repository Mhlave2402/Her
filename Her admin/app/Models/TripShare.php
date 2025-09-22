<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TripShare extends Model
{
    use HasFactory;

    protected $fillable = [
        'trip_id',
        'token',
        'expires_at',
    ];

    public function trip()
    {
        return $this->belongsTo(\Modules\TripManagement\Entities\TripRequest::class, 'trip_id');
    }
}
