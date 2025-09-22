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
        Schema::table('users', function (Blueprint $table) {
            $table->boolean('is_nanny')->default(false);
            $table->boolean('is_kids_only_verified')->default(false);
            $table->decimal('nanny_service_fee', 8, 2)->default(0);
            $table->decimal('kids_only_service_fee', 8, 2)->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('is_nanny');
            $table->dropColumn('is_kids_only_verified');
            $table->dropColumn('nanny_service_fee');
            $table->dropColumn('kids_only_service_fee');
        });
    }
};
