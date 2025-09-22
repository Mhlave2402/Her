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
        Schema::table('trip_requests', function (Blueprint $table) {
            if (!Schema::hasColumn('trip_requests', 'paid_fare')) {
                $table->decimal('paid_fare', 23, 3)->default(0);
            }
            if (!Schema::hasColumn('trip_requests', 'return_fee')) {
                $table->decimal('return_fee', 23, 3)->default(0)->after('paid_fare');
            }
            if (!Schema::hasColumn('trip_requests', 'return_time')) {
                $table->dateTime('return_time')->nullable()->after('return_fee');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('trip_requests', function (Blueprint $table) {
            $table->dropColumn(['return_fee','return_time']);
        });
    }
};
