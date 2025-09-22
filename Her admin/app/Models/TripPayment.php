<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TripPayment extends Model
{
    use HasFactory;

    protected $table = 'trip_request_payments';
    
    protected $fillable = [
        'participant_id',
        'amount',
        'payment_method',
        'status'
    ];

    public function participant()
    {
        return $this->belongsTo(TripParticipant::class);
    }
}
