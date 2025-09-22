import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

const String appId = "YOUR_AGORA_APP_ID";

class CallScreen extends StatefulWidget {
  final String channelName;

  const CallScreen({
    Key? key,
    required this.channelName,
  }) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late RtcEngine _engine;
  bool _localUserJoined = false;
  int? _remoteUid;

  String? _token;

  @override
  void initState() {
    super.initState();
    getToken().then((_) {
      initAgora();
    });
  }

  Future<void> getToken() async {
    final response = await http.get(
      Uri.parse('YOUR_BACKEND_URL/api/customer/agora-token?channelName=${widget.channelName}'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _token = jsonDecode(response.body)['token'];
      });
    }
  }

  Future<void> initAgora() async {
    if (_token == null) return;

    await [Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
          Navigator.of(context).pop();
        },
      ),
    );

    await _engine.joinChannel(
      token: _token!,
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? const RtcLocalView.SurfaceView()
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: widget.channelName,
      );
    } else {
      return const Text(
        'Calling...',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () => _onToggleMute(),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              _engine.isSpeakerphoneEnabled() ? Icons.volume_up : Icons.volume_off,
              color: Colors.blueAccent,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
          )
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      _engine.muteLocalAudioStream(!_engine.isSpeakerphoneEnabled());
    });
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
}
