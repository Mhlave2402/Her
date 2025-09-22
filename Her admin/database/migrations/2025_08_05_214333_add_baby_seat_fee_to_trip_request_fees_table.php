<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('trip_request_fees', function (Blueprint $table) {
            $table->double('baby_seat_fee', 8, 2)->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('trip_request_fees', function (Blueprint $table) {
            $table->dropColumn('baby_seat_fee');
        });
    }
};
