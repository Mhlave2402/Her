<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Twilio\Rest\Client;

class SendSmsNotificationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $phoneNumber;
    protected $message;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($phoneNumber, $message)
    {
        $this->phoneNumber = $phoneNumber;
        $this->message = $message;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $sid = env("TWILIO_SID");
        $token = env("TWILIO_TOKEN");
        $from = env("TWILIO_FROM");

        $client = new Client($sid, $token);

        $client->messages->create(
            $this->phoneNumber,
            [
                'from' => $from,
                'body' => $this->message
            ]
        );
    }
}
