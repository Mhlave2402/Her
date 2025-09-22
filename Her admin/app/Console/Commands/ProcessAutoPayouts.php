<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Modules\UserManagement\Entities\UserAccount;
use App\Jobs\ProcessPayoutJob;

class ProcessAutoPayouts extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'payouts:process';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Process automatic payouts for eligible drivers';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Processing auto-payouts...');

        $eligibleDrivers = UserAccount::where('auto_withdraw_enabled', true)
            ->where(function ($query) {
                $query->where('receivable_balance', '>=', 'payout_threshold')
                      ->orWhere('next_payout_date', '<=', now());
            })
            ->get();

        foreach ($eligibleDrivers as $driverAccount) {
            ProcessPayoutJob::dispatch($driverAccount);
        }

        $this->info('Auto-payout processing complete.');
    }
}
