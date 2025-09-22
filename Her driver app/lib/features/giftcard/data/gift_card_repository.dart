import 'package:get/get.dart';
import 'package:her_driver_app/data/api/api_client.dart';
import 'package:her_driver_app/util/app_constants.dart';

class GiftCardRepository {
  final ApiClient apiClient;
  GiftCardRepository({required this.apiClient});

  Future<Response> getGiftCardList() async {
    return await apiClient.getData(AppConstants.giftCardListUri);
  }

  Future<Response> getTripPayment(String tripId) async {
    return await apiClient.getData('${AppConstants.tripPaymentUri}/$tripId');
  }
}
