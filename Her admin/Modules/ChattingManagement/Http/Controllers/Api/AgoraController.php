<?php

namespace Modules\ChattingManagement\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
require_once app_path('Agora/RtcTokenBuilder.php');

class AgoraController extends Controller
{
    public function generateToken(Request $request)
    {
        $appID = env('AGORA_APP_ID');
        $appCertificate = env('AGORA_APP_CERTIFICATE');
        $channelName = $request->channelName;
        $uid = 0; // Let Agora assign UID
        $role = \RtcTokenBuilder::RolePublisher;
        $expireTimeInSeconds = 3600;

        $currentTimestamp = now()->timestamp;
        $privilegeExpireTs = $currentTimestamp + $expireTimeInSeconds;

        $token = \RtcTokenBuilder::buildTokenWithUid(
            $appID,
            $appCertificate,
            $channelName,
            $uid,
            $role,
            $privilegeExpireTs
        );

        return response()->json(['token' => $token]);
    }
}
