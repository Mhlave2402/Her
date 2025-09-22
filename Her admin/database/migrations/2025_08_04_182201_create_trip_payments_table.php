<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('trip_request_payments')) {
            Schema::create('trip_request_payments', function (Blueprint $table) {
                $table->id();
                $table->unsignedBigInteger('participant_id');
                $table->foreign('participant_id')->references('id')->on('trip_request_participants')->onDelete('cascade');
                $table->decimal('amount', 10, 2);
                $table->string('payment_method');
                $table->string('status')->default('pending');
                $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('trip_request_payments');
    }
};
