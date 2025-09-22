<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSOSSTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('s_o_s_s')) {
            Schema::create('s_o_s_s', function (Blueprint $table) {
                $table->id();
                $table->foreignUuid('user_id')->constrained('users')->onDelete('cascade');
                $table->foreignUuid('trip_id')->nullable()->constrained('trip_requests')->onDelete('cascade');
                $table->string('latitude');
                $table->string('longitude');
                $table->text('note')->nullable();
                $table->timestamps();
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
        Schema::dropIfExists('s_o_s_s');
    }
}
