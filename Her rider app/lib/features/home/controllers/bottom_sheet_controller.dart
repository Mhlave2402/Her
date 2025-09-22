import 'package:get/get.dart';
import 'package:her_user_app/features/home/domain/models/vehicle_category_model.dart';
import 'package:her_user_app/features/home/domain/repos/category_repo.dart';

enum BottomSheetState {
  loading,
  success,
  error,
}

class BottomSheetController extends GetxController {
  final CategoryRepo categoryRepo;
  BottomSheetController({required this.categoryRepo});

  var _bottomSheetState = BottomSheetState.loading;
  BottomSheetState get bottomSheetState => _bottomSheetState;

  List<VehicleCategoryModel>? _vehicleCategories;
  List<VehicleCategoryModel>? get vehicleCategories => _vehicleCategories;

  Future<void> getVehicleCategories() async {
    _bottomSheetState = BottomSheetState.loading;
    update();
    try {
      final response = await categoryRepo.getVehicleCategories();
      if (response.statusCode == 200) {
        _vehicleCategories = (response.body as List)
            .map((category) => VehicleCategoryModel.fromJson(category))
            .toList();
        _bottomSheetState = BottomSheetState.success;
      } else {
        _bottomSheetState = BottomSheetState.error;
      }
    } catch (e) {
      _bottomSheetState = BottomSheetState.error;
    }
    update();
  }
}
