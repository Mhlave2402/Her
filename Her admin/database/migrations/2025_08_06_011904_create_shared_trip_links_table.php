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
        Schema::dropIfExists('shared_trip_links');
        Schema::create('shared_trip_links', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->foreignUuid('trip_request_id')->constrained('trip_requests')->onDelete('cascade');
            $table->string('token')->unique();
            $table->timestamp('expires_at');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('shared_trip_links');
    }
};
