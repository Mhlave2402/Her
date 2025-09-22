<?php

namespace Modules\UserManagement\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Crypt;
use Modules\Gateways\Traits\HasUuid;
use Modules\UserManagement\Database\Factories\UserWithdrawMethodInfoFactory;

class UserWithdrawMethodInfo extends Model
{
    use HasFactory, SoftDeletes, HasUuid;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'method_name',
        'user_id',
        'withdraw_method_id',
        'method_info',
        'is_active',
        'created_at',
        'updated_at',
    ];
    protected $casts = [
        'is_active'=>'boolean',
    ];

    /**
     * Encrypt the method_info attribute.
     *
     * @param  string  $value
     * @return void
     */
    public function setMethodInfoAttribute($value)
    {
        $this->attributes['method_info'] = Crypt::encryptString(json_encode($value));
    }

    /**
     * Decrypt the method_info attribute.
     *
     * @param  string  $value
     * @return string
     */
    public function getMethodInfoAttribute($value)
    {
        try {
            return json_decode(Crypt::decryptString($value), true);
        } catch (\Illuminate\Contracts\Encryption\DecryptException $e) {
            return null;
        }
    }


    protected static function newFactory(): UserWithdrawMethodInfoFactory
    {
        //return UserWithdrawMethodInfoFactory::new();
    }

    public function user(){
        return $this->belongsTo(User::class);
    }
    public function withdrawMethod(){
        return $this->belongsTo(WithdrawMethod::class);
    }
}
