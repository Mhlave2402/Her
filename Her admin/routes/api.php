<?php

use App\Http\Controllers\Api\IdentityVerificationController;
use App\Http\Controllers\Api\TripShareController;
use App\Http\Controllers\Api\Driver\LocationController;
use App\Http\Controllers\Api\VehicleCategoryController;
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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['prefix' => 'v1', 'as' => 'api.v1.'], function () {
    Route::get('fees/apply', [\App\Http\Controllers\Api\V1\FeeController::class, 'getApplicableFees'])->name('fees.apply');
});

Route::group(['prefix' => 'nannies', 'middleware' => ['auth:api', 'admin']], function () {
    Route::get('/', 'Api\NannyController@index');
    Route::put('/{id}/verify', 'Api\NannyController@verify');
    Route::put('/{id}/fee', 'Api\NannyController@setFee');
});


Route::post('/trip/share', [TripShareController::class, 'share']);
Route::post('/driver/location', [LocationController::class, 'update']);

Route::middleware('auth:api')->group(function () {
    Route::post('/identity-verification/upload', [IdentityVerificationController::class, 'upload']);
    Route::get('/identity-verification/status', [IdentityVerificationController::class, 'status']);
});

Route::group(['prefix' => 'v1/admin', 'as' => 'api.v1.admin.', 'middleware' => ['auth:api', 'admin']], function () {
    Route::apiResource('feature-fee-configs', \App\Http\Controllers\Api\V1\Admin\FeatureFeeConfigController::class);
    Route::get('feature-fee-configs/{configId}/audit-logs', [\App\Http\Controllers\Api\V1\Admin\FeatureFeeConfigController::class, 'auditLogs'])->name('feature-fee-configs.audit-logs');
});

Route::group(['prefix' => 'v1', 'as' => 'api.v1.'], function () {
    Route::get('premium-features', [\App\Http\Controllers\Api\V1\PremiumFeatureController::class, 'index'])->name('premium-features.index');
});

Route::get('/vehicle-categories', [VehicleCategoryController::class, 'index']);

Route::middleware('auth:api')->group(function () {
    Route::post('/wallet/redeem-gift-card', [\App\Http\Controllers\Api\WalletController::class, 'redeemGiftCard']);
    Route::post('/wallet/top-up-with-card', [\App\Http\Controllers\Api\WalletController::class, 'topUpWithCard']);
});
