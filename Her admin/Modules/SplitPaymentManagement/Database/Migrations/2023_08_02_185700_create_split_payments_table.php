<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSplitPaymentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if (!Schema::hasTable('split_payments')) {
            Schema::create('split_payments', function (Blueprint $table) {
                $table->id();
                $table->foreignUuid('trip_id')->constrained('trip_requests')->onDelete('cascade');
                $table->foreignUuid('user_id')->constrained('users')->onDelete('cascade');
                $table->foreignUuid('with_user_id')->constrained('users')->onDelete('cascade');
                $table->string('status')->default('pending');
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
        Schema::dropIfExists('split_payments');
    }
}
