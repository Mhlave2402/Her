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
        Schema::dropIfExists('feature_fee_configs');
        Schema::create('feature_fee_configs', function (Blueprint $table) {
            $table->id();
            $table->string('feature_key');
            $table->foreignUuid('zone_id')->nullable()->constrained()->onDelete('cascade');
            $table->string('vehicle_type')->nullable();
            $table->enum('pricing_model', ['flat', 'percentage', 'per_km', 'per_min', 'tiered']);
            $table->decimal('value', 10, 2);
            $table->json('tier_config')->nullable();
            $table->decimal('min_fee', 10, 2)->nullable();
            $table->decimal('max_fee', 10, 2)->nullable();
            $table->enum('apply_on', ['base_fare', 'fare_total'])->nullable();
            $table->timestamp('start_at')->nullable();
            $table->timestamp('end_at')->nullable();
            $table->boolean('is_active')->default(true);
            $table->integer('priority')->default(0);
            $table->foreignUuid('created_by')->nullable()->constrained('users')->onDelete('set null');
            $table->foreignUuid('updated_by')->nullable()->constrained('users')->onDelete('set null');
            $table->json('payout_rule')->nullable();
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
        Schema::dropIfExists('feature_fee_configs');
    }
};
