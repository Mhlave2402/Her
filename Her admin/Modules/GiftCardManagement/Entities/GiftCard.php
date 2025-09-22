<?php

namespace Modules\GiftCardManagement\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use App\Models\User;

class GiftCard extends Model
{
    use HasFactory;

    protected $fillable = [
        'code',
        'amount',
        'user_id',
        'expires_at',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
