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
        Schema::dropIfExists('feature_fee_audit_logs');
        Schema::create('feature_fee_audit_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('feature_fee_config_id')->constrained()->onDelete('cascade');
            $table->foreignUuid('user_id')->nullable()->constrained()->onDelete('set null');
            $table->json('before');
            $table->json('after');
            $table->timestamp('changed_at');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('feature_fee_audit_logs');
    }
};
