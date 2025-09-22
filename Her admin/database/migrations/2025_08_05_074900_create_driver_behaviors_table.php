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
        if (!Schema::hasTable('driver_behaviors')) {
            Schema::create('driver_behaviors', function (Blueprint $table) {
                $table->id();
                $table->foreignUuid('driver_id')->constrained('users')->onDelete('cascade');
                $table->foreignUuid('trip_id')->nullable()->constrained('trip_requests')->onDelete('cascade');
                $table->enum('event_type', ['speeding', 'hard_braking']);
                $table->double('threshold_exceeded')->comment('How much over the speed limit or braking threshold');
                $table->point('location')->nullable()->comment('GPS coordinates of event');
                $table->boolean('reported')->default(false)->comment('Admin reviewed this event');
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('driver_behaviors');
    }
};
