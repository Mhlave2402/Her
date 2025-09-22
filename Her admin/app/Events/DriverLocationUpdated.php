<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use Modules\TripManagement\Entities\TripRequest;

class DriverLocationUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $tripRequest;

    public function __construct(TripRequest $tripRequest)
    {
        $this->tripRequest = $tripRequest;
    }

    public function broadcastOn()
    {
        return new PrivateChannel('trip.' . $this->tripRequest->id);
    }
}
