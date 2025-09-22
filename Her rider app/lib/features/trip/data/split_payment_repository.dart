import 'package:get/get.dart';
import 'package:her_user_app/data/api_client.dart';
import 'package:her_user_app/util/app_constants.dart';

class SplitPaymentRepository {
  final ApiClient apiClient;
  SplitPaymentRepository({required this.apiClient});

  Future<Response> requestSplitPayment(int tripId, int userId) async {
    return await apiClient.postData(AppConstants.splitPaymentRequestUri, {
      'trip_id': tripId,
      'user_id': userId,
    });
  }

  Future<Response> acceptSplitPayment(int splitPaymentId) async {
    return await apiClient.postData(AppConstants.splitPaymentAcceptUri, {
      'split_payment_id': splitPaymentId,
    });
  }
}
