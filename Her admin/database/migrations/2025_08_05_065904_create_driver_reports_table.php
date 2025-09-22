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
        if (!Schema::hasTable('driver_reports')) {
            Schema::create('driver_reports', function (Blueprint $table) {
                $table->id();
                $table->foreignUuid('driver_id')->constrained('users')->onDelete('cascade');
                $table->foreignUuid('user_id')->constrained('users')->onDelete('cascade');
                $table->string('reason');
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
        Schema::dropIfExists('driver_reports');
    }
};
