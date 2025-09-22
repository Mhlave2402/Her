<?php

use Illuminate\Support\Facades\Route;
use Modules\TripManagement\Http\Controllers\Api\New\Driver\TripRequestController;
use Modules\TripManagement\Http\Controllers\ShortfallController;

Route::group(['prefix' => 'driver', 'middleware' => ['auth:api', 'driver']], function () {
    Route::get('trip-request/{trip_id}', [TripRequestController::class, 'show']);
    Route::post('trip-request/accept', [TripRequestController::class, 'accept']);
    Route::post('trip-request/decline', [TripRequestController::class, 'decline']);
    Route::post('ride/shortfall/record', [ShortfallController::class, 'recordShortfall']);
});

Route::group(['prefix' => 'customer', 'middleware' => ['auth:api']], function () {
    Route::post('ride/shortfall/pay', [ShortfallController::class, 'payShortfall']);
});
