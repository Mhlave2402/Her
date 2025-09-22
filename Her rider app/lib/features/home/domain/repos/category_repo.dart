import 'package:her_user_app/data/api_client.dart';
import 'package:her_user_app/util/app_constants.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response> getVehicleCategories() async {
    return await apiClient.getData(AppConstants.vehicleCategoryUri);
  }
}
