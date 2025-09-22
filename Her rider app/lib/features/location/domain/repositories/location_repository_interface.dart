import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:her_user_app/features/address/domain/models/address_model.dart';
import 'package:her_user_app/interface/repository_interface.dart';

abstract class LocationRepositoryInterface implements RepositoryInterface{
  Future<dynamic> getZone(String lat, String lng);
  Future<dynamic> getAddressFromGeocode(LatLng? latLng);
  Future<dynamic> searchLocation(String text, String latitude, String longitude);
  Future<dynamic> getPlaceDetails(String placeID);
  Future<bool> saveUserAddress(Address? address);
  String? getUserAddress();
}
