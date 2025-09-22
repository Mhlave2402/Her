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
        if (!Schema::hasTable('trip_shares')) {
            Schema::create('trip_shares', function (Blueprint $table) {
                $table->id();
                $table->foreignUuid('trip_id')->constrained('trip_requests')->onDelete('cascade');
                $table->string('token');
                $table->timestamp('expires_at');
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('trip_shares');
    }
};
