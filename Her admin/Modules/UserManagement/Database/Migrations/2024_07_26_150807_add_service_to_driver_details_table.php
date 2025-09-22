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
        Schema::table('driver_details', function (Blueprint $table) {
            if (!Schema::hasColumn('driver_details', 'idle_time')) {
                $table->double('idle_time', 23, 2)->default(0);
            }
            if (!Schema::hasColumn('driver_details', 'service')) {
                $table->json('service')->nullable()->after('idle_time');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('driver_details', function (Blueprint $table) {
            $table->dropColumn('service');
        });
    }
};
