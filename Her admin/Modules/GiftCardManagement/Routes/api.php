<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['prefix' => 'customer'], function() {
    Route::post('giftcard/redeem', 'GiftCardController@redeem');
    Route::get('giftcard/balance', 'GiftCardController@balance');
    Route::get('giftcard/list', 'GiftCardController@list');
});

Route::group(['prefix' => 'driver'], function() {
    Route::get('giftcard/trip-payment/{trip_id}', 'GiftCardController@getTripPayment');
});
