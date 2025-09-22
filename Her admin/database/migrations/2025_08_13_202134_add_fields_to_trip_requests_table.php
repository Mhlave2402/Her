<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('trip_requests', function (Blueprint $table) {
            $table->json('pickup_location')->nullable();
            $table->json('dropoff_location')->nullable();
            $table->float('pickup_distance_km')->nullable();
            $table->renameColumn('estimated_distance', 'trip_distance_km');
            $table->integer('estimated_time_to_pickup')->nullable();
            $table->integer('countdown_seconds')->nullable();
            $table->float('client_rating')->nullable();
            $table->json('security_flags')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('trip_requests', function (Blueprint $table) {
            $table->dropColumn('pickup_location');
            $table->dropColumn('dropoff_location');
            $table->dropColumn('pickup_distance_km');
            $table->renameColumn('trip_distance_km', 'estimated_distance');
            $table->dropColumn('estimated_time_to_pickup');
            $table->dropColumn('countdown_seconds');
            $table->dropColumn('client_rating');
            $table->dropColumn('security_flags');
        });
    }
};
