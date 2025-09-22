<?php

namespace App\Service;

use Kreait\Firebase\Factory;
use Modules\UserManagement\Service\Interface\UserServiceInterface;

class ChatSessionService
{
    protected $firestore;
    protected $userService;

    public function __construct(UserServiceInterface $userService)
    {
        $factory = (new Factory)->withServiceAccount(config('services.firebase.credentials'));
        $this->firestore = $factory->createFirestore();
        $this->userService = $userService;
    }

    public function create($tripId, $driverId, $riderId)
    {
        $this->firestore->collection('chats')->document($tripId)->set([
            'driverId' => $driverId,
            'riderId' => $riderId,
            'tripId' => $tripId,
            'createdAt' => now(),
        ]);

        $driver = $this->userService->findOne($driverId);
        $rider = $this->userService->findOne($riderId);

        $push = getNotification('new_chat_message');

        sendDeviceNotification(
            fcm_token: $driver->fcm_token,
            title: translate($push['title']),
            description: translate($push['description']),
            ride_request_id: $tripId,
            type: 'chat',
            user_id: $driverId
        );

        sendDeviceNotification(
            fcm_token: $rider->fcm_token,
            title: translate($push['title']),
            description: translate($push['description']),
            ride_request_id: $tripId,
            type: 'chat',
            user_id: $riderId
        );
    }
}
