<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('trip_request_participants')) {
            Schema::create('trip_request_participants', function (Blueprint $table) {
            $table->id();
            $table->foreignUuid('trip_id')->constrained('trip_requests')->onDelete('cascade');
            $table->foreignUuid('user_id')->constrained('users')->onDelete('cascade');
            $table->decimal('share_percentage', 5, 2)->default(100);
            $table->decimal('amount_paid', 10, 2)->default(0);
            $table->boolean('is_primary')->default(false);
            $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('trip_request_participants');
    }
};
