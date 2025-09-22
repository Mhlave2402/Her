<?php

namespace Modules\SplitPaymentManagement\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\User;
use Modules\TripManagement\Entities\TripRequest;

class SplitPayment extends Model
{
    use HasFactory;

    protected $fillable = [
        'trip_id',
        'user_id',
        'with_user_id',
        'status',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function withUser()
    {
        return $this->belongsTo(User::class, 'with_user_id');
    }

    public function trip()
    {
        return $this->belongsTo(TripRequest::class);
    }
}
