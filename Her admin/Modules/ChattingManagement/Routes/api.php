<?php

use Illuminate\Support\Facades\Route;
use Modules\ChattingManagement\Http\Controllers\Api\AgoraController;

Route::group(['prefix' => 'customer'], function () {
    Route::get('agora-token', [AgoraController::class, 'generateToken']);
});
