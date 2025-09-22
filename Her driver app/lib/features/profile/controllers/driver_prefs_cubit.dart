import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/profile/controllers/profile_controller.dart';
import 'package:her_driver_app/features/profile/domain/repositories/driver_prefs_repository.dart';

class DriverTierPrefsState {
  final String registeredTier;
  final Map<String, bool> globalPrefs;
  final Map<String, Map<String, bool>> perVehiclePrefs;
  final List<dynamic> vehicles;
  final bool busy;

  DriverTierPrefsState({
    required this.registeredTier,
    required this.globalPrefs,
    required this.perVehiclePrefs,
    required this.vehicles,
    required this.busy,
  });

  DriverTierPrefsState copyWith({
    String? registeredTier,
    Map<String, bool>? globalPrefs,
    Map<String, Map<String, bool>>? perVehiclePrefs,
    List<dynamic>? vehicles,
    bool? busy,
  }) {
    return DriverTierPrefsState(
      registeredTier: registeredTier ?? this.registeredTier,
      globalPrefs: globalPrefs ?? this.globalPrefs,
      perVehiclePrefs: perVehiclePrefs ?? this.perVehiclePrefs,
      vehicles: vehicles ?? this.vehicles,
      busy: busy ?? this.busy,
    );
  }
}

class DriverPrefsCubit extends Cubit<DriverTierPrefsState> {
  final DriverPrefsRepository driverPrefsRepository;

  DriverPrefsCubit({required this.driverPrefsRepository})
      : super(DriverTierPrefsState(
          registeredTier: '',
          globalPrefs: {},
          perVehiclePrefs: {},
          vehicles: [],
          busy: false,
        ));

  Future<void> getTierSettings() async {
    emit(state.copyWith(busy: true));
    final response = await driverPrefsRepository.getTierSettings();
    if (response != null) {
      emit(state.copyWith(
        registeredTier: response['driver']['registered_tier'],
        globalPrefs: Map<String, bool>.from(response['preferences']['global']),
        perVehiclePrefs: Map<String, Map<String, bool>>.from(response['preferences']['per_vehicle']),
        vehicles: response['vehicles'],
        busy: false,
      ));
    } else {
      emit(state.copyWith(busy: false));
    }
  }

  Future<void> updateTierSettings(Map<String, bool> global, Map<String, Map<String, bool>> perVehicle) async {
    emit(state.copyWith(busy: true));
    final response = await driverPrefsRepository.updateTierSettings(global, perVehicle);
    if (response != null) {
      getTierSettings();
    } else {
      emit(state.copyWith(busy: false));
    }
  }

  Future<void> toggleVehicleActive(String vehicleId) async {
    emit(state.copyWith(busy: true));
    final response = await driverPrefsRepository.toggleVehicleActive(vehicleId);
    if (response != null) {
      getTierSettings();
    } else {
      emit(state.copyWith(busy: false));
    }
  }
}
