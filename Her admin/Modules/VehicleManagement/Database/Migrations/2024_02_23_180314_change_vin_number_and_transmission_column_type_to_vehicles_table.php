<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('vehicles', function (Blueprint $table) {
            if (Schema::hasColumn('vehicles', 'vin_number')) {
                $table->string('vin_number')->nullable()->change();
            }
            if (Schema::hasColumn('vehicles', 'transmission')) {
                $table->string('transmission')->nullable()->change();
            } else {
                $table->string('transmission')->nullable();
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('vehicles', function (Blueprint $table) {

        });
    }
};
