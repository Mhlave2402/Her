import 'package:get/get.dart';
import 'package:her_driver_app/features/giftcard/data/gift_card_repository.dart';
import 'package:her_driver_app/features/giftcard/models/gift_card_model.dart';

class GiftCardController extends GetxController implements GetxService {
  final GiftCardRepository giftCardRepository;
  GiftCardController({required this.giftCardRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<GiftCard> _giftCards = [];
  List<GiftCard> get giftCards => _giftCards;

  Future<void> getGiftCardList() async {
    _isLoading = true;
    update();
    Response response = await giftCardRepository.getGiftCardList();
    if (response.statusCode == 200) {
      _giftCards = [];
      response.body.forEach((giftCard) {
        _giftCards.add(GiftCard.fromJson(giftCard));
      });
    } else {
      // showCustomSnackBar(response.statusText!, isError: true);
    }
    _isLoading = false;
    update();
  }

  Future<Map<String, dynamic>> getTripPayment(String tripId) async {
    _isLoading = true;
    update();
    Response response = await giftCardRepository.getTripPayment(tripId);
    Map<String, dynamic> result = {'paid_by_gift_card': false, 'amount': 0.0};
    if (response.statusCode == 200) {
      result['paid_by_gift_card'] = response.body['paid_by_gift_card'];
      result['amount'] = response.body['amount'];
    } else {
      // showCustomSnackBar(response.statusText!, isError: true);
    }
    _isLoading = false;
    update();
    return result;
  }
}
