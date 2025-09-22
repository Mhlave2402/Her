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
        Schema::rename('s_o_s_s', 'sos');
        // Check and add the column if it doesn't exist
        if (!Schema::hasColumn('sos', 'user_id')) {
            Schema::table('sos', function (Blueprint $table) {
                $table->foreignUuid('user_id')->nullable()->constrained('users')->onDelete('cascade');
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
        // Drop the foreign key and the column
        Schema::table('sos', function (Blueprint $table) {
            $table->dropForeign(['user_id']);
            $table->dropColumn('user_id');
        });
        Schema::rename('sos', 's_o_s_s');
    }
};