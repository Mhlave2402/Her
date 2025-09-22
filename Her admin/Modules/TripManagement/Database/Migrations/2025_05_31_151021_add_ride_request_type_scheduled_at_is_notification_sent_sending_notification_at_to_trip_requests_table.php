<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::table('trip_requests', function (Blueprint $table) {
            if (!Schema::hasColumn('trip_requests', 'type')) {
                $table->string('type')->nullable();
            }
            if (!Schema::hasColumn('trip_requests', 'current_status')) {
                $table->string('current_status', 20)->default('pending');
            }
            if (!Schema::hasColumn('trip_requests', 'ride_request_type')) {
                $table->string('ride_request_type')->after('type')->nullable();
            }
            if (!Schema::hasColumn('trip_requests', 'scheduled_at')) {
                $table->string('scheduled_at')->after('ride_request_type')->nullable();
            }
            if (!Schema::hasColumn('trip_requests', 'is_notification_sent')) {
                $table->boolean('is_notification_sent')->default(1)->after('current_status');
            }
            if (!Schema::hasColumn('trip_requests', 'sending_notification_at')) {
                $table->string('sending_notification_at')->after('is_notification_sent')->nullable();
            }
        });
    }

    public function down(): void
    {
        Schema::table('trip_requests', function (Blueprint $table) {
            $table->dropColumn('ride_request_type');
            $table->dropColumn('scheduled_at');
            $table->dropColumn('is_notification_sent');
            $table->dropColumn('sending_notification_at');
        });
    }
};
