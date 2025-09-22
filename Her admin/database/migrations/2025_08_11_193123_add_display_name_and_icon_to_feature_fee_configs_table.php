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
        Schema::table('feature_fee_configs', function (Blueprint $table) {
            $table->string('display_name')->after('feature_key');
            $table->string('icon')->after('display_name');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('feature_fee_configs', function (Blueprint $table) {
            $table->dropColumn('display_name');
            $table->dropColumn('icon');
        });
    }
};
