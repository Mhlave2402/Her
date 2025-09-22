import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import '../domain/entities/trip_request.dart';

class TripRequestState {
  final TripRequest? trip;
  final bool isLoading;
  final String? error;

  TripRequestState({this.trip, this.isLoading = false, this.error});
}

class TripRequestCubit extends Cubit<TripRequestState> {
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:6001'),
  );
  final AudioPlayer _audioPlayer = AudioPlayer();

  TripRequestCubit() : super(TripRequestState()) {
    _channel.stream.listen((data) {
      final decoded = jsonDecode(data);
      if (decoded['event'] == 'Modules\\TripManagement\\Events\\TripRequested') {
        final tripData = jsonDecode(decoded['data'])['trip'];
        final trip = TripRequest.fromJson(tripData);
        emit(TripRequestState(trip: trip));
        _playNotificationSound();
        _vibrate();
      }
    });
  }

  Future<void> _playNotificationSound() async {
    await _audioPlayer.play(AssetSource('notification.wav'));
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }
  }

  Future<void> acceptTrip(String tripId) async {
    emit(TripRequestState(isLoading: true));
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/driver/trip-request/accept'),
        body: {'trip_id': tripId},
      );
      if (response.statusCode == 200) {
        emit(TripRequestState(trip: null));
      } else {
        emit(TripRequestState(error: 'Failed to accept trip: ${response.body}'));
      }
    } catch (e) {
      emit(TripRequestState(error: 'Failed to accept trip: $e'));
    }
  }

  Future<void> declineTrip(String tripId) async {
    emit(TripRequestState(isLoading: true));
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/driver/trip-request/decline'),
        body: {'trip_id': tripId},
      );
      if (response.statusCode == 200) {
        emit(TripRequestState(trip: null));
      } else {
        emit(TripRequestState(error: 'Failed to decline trip: ${response.body}'));
      }
    } catch (e) {
      emit(TripRequestState(error: 'Failed to decline trip: $e'));
    }
  }

  Future<void> passTrip(String tripId) async {
    emit(TripRequestState(isLoading: true));
    try {
      // Assuming 'pass' is the same as 'decline' for now
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/driver/trip-request/decline'),
        body: {'trip_id': tripId, 'reason': 'passed'},
      );
      if (response.statusCode == 200) {
        emit(TripRequestState(trip: null));
      } else {
        emit(TripRequestState(error: 'Failed to pass trip: ${response.body}'));
      }
    } catch (e) {
      emit(TripRequestState(error: 'Failed to pass trip: $e'));
    }
  }

  Future<void> placeBid(String tripId, String amount) async {
    emit(TripRequestState(isLoading: true));
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/driver/trip-request/bid'),
        body: {'trip_id': tripId, 'bid_fare': amount},
      );
      if (response.statusCode == 200) {
        emit(TripRequestState(trip: null));
      } else {
        emit(TripRequestState(error: 'Failed to place bid: ${response.body}'));
      }
    } catch (e) {
      emit(TripRequestState(error: 'Failed to place bid: $e'));
    }
  }

  @override
  Future<void> close() {
    _channel.sink.close();
    _audioPlayer.dispose();
    return super.close();
  }
}
