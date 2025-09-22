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
        Schema::dropIfExists('trip_feature_charges');
        Schema::create('trip_feature_charges', function (Blueprint $table) {
            $table->id();
            $table->foreignUuid('trip_id')->constrained('trip_requests')->onDelete('cascade');
            $table->string('feature_key');
            $table->decimal('amount', 10, 2);
            $table->foreignId('applied_by_config_id')->constrained('feature_fee_configs')->onDelete('cascade');
            $table->timestamp('applied_at');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('trip_feature_charges');
    }
};
