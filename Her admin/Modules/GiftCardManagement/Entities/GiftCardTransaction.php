<?php

namespace Modules\GiftCardManagement\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class GiftCardTransaction extends Model
{
    use HasFactory;

    protected $fillable = [
        'gift_card_id',
        'user_id',
        'trip_request_id',
        'amount',
    ];

    protected static function newFactory()
    {
        return \Modules\GiftCardManagement\Database\factories\GiftCardTransactionFactory::new();
    }
}
