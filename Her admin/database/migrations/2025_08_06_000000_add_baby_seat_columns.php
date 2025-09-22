<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('driver_details', function (Blueprint $table) {
            $table->boolean('has_baby_seat')->default(false);
        });

        Schema::table('trip_requests', function (Blueprint $table) {
            $table->boolean('baby_seat_requested')->default(false);
            $table->decimal('baby_seat_fee', 8, 2)->default(0.00);
        });
    }

    public function down()
    {
        Schema::table('driver_details', function (Blueprint $table) {
            $table->dropColumn('has_baby_seat');
        });

        Schema::table('trip_requests', function (Blueprint $table) {
            $table->dropColumn('baby_seat_requested');
            $table->dropColumn('baby_seat_fee');
        });
    }
};
