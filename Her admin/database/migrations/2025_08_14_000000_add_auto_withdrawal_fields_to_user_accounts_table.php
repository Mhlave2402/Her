<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddAutoWithdrawalFieldsToUserAccountsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_accounts', function (Blueprint $table) {
            $table->boolean('auto_withdraw_enabled')->default(false)->after('total_withdrawn');
            $table->decimal('payout_threshold', 24, 2)->nullable()->after('auto_withdraw_enabled');
            $table->string('payout_schedule')->default('manual')->after('payout_threshold'); // e.g., manual, daily, weekly, monthly
            $table->timestamp('next_payout_date')->nullable()->after('payout_schedule');
            $table->string('last_payout_status')->nullable()->after('next_payout_date');
        });

        Schema::table('user_withdraw_method_infos', function (Blueprint $table) {
            $table->boolean('is_default')->default(false)->after('method_info');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_accounts', function (Blueprint $table) {
            $table->dropColumn(['auto_withdraw_enabled', 'payout_threshold', 'payout_schedule', 'next_payout_date', 'last_payout_status']);
        });

        Schema::table('user_withdraw_method_infos', function (Blueprint $table) {
            $table->dropColumn('is_default');
        });
    }
}
