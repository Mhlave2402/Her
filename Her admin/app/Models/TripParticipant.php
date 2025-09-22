<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Modules\TripManagement\Entities\TripRequest;

class TripParticipant extends Model
{
    use HasFactory;

    protected $table = 'trip_request_participants';
    
    protected $fillable = [
        'trip_id',
        'user_id',
        'share_percentage',
        'amount_paid',
        'is_primary'
    ];

    public function trip()
    {
        return $this->belongsTo(TripRequest::class);
    }

    public function user()
    {
        return $this->belongsTo(\Modules\UserManagement\Entities\User::class);
    }

    public function payments()
    {
        return $this->hasMany(TripPayment::class);
    }
}
