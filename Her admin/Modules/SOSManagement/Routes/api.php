<?php

use Illuminate\Support\Facades\Route;
use Modules\SOSManagement\Http\Controllers\Api\SOSController;

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

Route::group(['prefix' => 'customer', 'middleware' => 'auth:api'], function() {
    Route::post('sos', [SOSController::class, 'store']);
});

Route::group(['prefix' => 'driver', 'middleware' => 'auth:api'], function() {
    Route::post('sos', [SOSController::class, 'store']);
});
