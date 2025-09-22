<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::group(['prefix' => 'admin', 'middleware' => 'admin'], function () {
    Route::resource('giftcard', 'GiftCardController');
    Route::post('giftcard/bulk-generate', 'GiftCardController@bulkGenerate')->name('admin.giftcard.bulkGenerate');
});
