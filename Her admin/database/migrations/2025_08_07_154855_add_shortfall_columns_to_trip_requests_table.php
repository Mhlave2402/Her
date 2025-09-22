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
            $table->float('shortfall_amount')->default(0);
            $table->float('amount_paid_in_cash')->default(0);
            $table->boolean('is_shortfall_active')->default(false);
            $table->integer('shortfall_installments_remaining')->default(0);
            $table->float('shortfall_per_trip')->default(0);
            $table->boolean('shortfall_recovery_completed')->default(false);
            $table->float('shortfall_paid_total')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('trip_requests', function (Blueprint $table) {
            $table->dropColumn('shortfall_amount');
            $table->dropColumn('amount_paid_in_cash');
            $table->dropColumn('is_shortfall_active');
            $table->dropColumn('shortfall_installments_remaining');
            $table->dropColumn('shortfall_per_trip');
            $table->dropColumn('shortfall_recovery_completed');
            $table->dropColumn('shortfall_paid_total');
        });
    }
};
