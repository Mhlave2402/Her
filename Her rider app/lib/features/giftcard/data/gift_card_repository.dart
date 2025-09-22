import 'package:get/get.dart';
import 'package:her_user_app/data/api_client.dart';
import 'package:her_user_app/util/app_constants.dart';

class GiftCardRepository {
  final ApiClient apiClient;
  GiftCardRepository({required this.apiClient});

  Future<Response> redeemGiftCard(String code) async {
    return await apiClient.postData(AppConstants.giftCardRedeemUri, {'code': code});
  }

  Future<Response> getBalance() async {
    return await apiClient.getData(AppConstants.giftCardBalanceUri);
  }

  Future<Response> getGiftCardList() async {
    return await apiClient.getData(AppConstants.giftCardListUri);
  }
}
