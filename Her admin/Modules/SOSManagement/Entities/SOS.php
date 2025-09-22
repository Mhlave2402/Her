<?php

namespace Modules\SOSManagement\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\User;
use Modules\TripManagement\Entities\TripRequest;

class SOS extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'trip_id',
        'latitude',
        'longitude',
        'note',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function trip()
    {
        return $this->belongsTo(TripRequest::class);
    }
}
