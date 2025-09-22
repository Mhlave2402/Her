import 'package:get/get.dart';
import 'package:her_user_app/common_widgets/custom_snackbar.dart';
import 'package:her_user_app/features/giftcard/data/gift_card_repository.dart';
import 'package:her_user_app/features/giftcard/models/gift_card_model.dart';
import 'package:her_user_app/features/giftcard/screens/gift_card_list_screen.dart';

class GiftCardController extends GetxController implements GetxService {
  final GiftCardRepository giftCardRepository;
  GiftCardController({required this.giftCardRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double _balance = 0.0;
  double get balance => _balance;

  List<GiftCard> _giftCards = [];
  List<GiftCard> get giftCards => _giftCards;

  Future<void> redeemGiftCard(String code) async {
    _isLoading = true;
    update();
    Response response = await giftCardRepository.redeemGiftCard(code);
    if (response.statusCode == 200) {
      customSnackBar('Gift card redeemed successfully', isError: false);
      getBalance();
    } else {
      customSnackBar(response.body['message'], isError: true);
    }
    _isLoading = false;
    update();
  }

  Future<void> getBalance() async {
    Response response = await giftCardRepository.getBalance();
    if (response.statusCode == 200) {
      _balance = response.body['balance'].toDouble();
    } else {
      customSnackBar(response.statusText!, isError: true);
    }
    update();
  }

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
      customSnackBar(response.statusText!, isError: true);
    }
    _isLoading = false;
    update();
  }

  void navigateToGiftCardListScreen() {
    Get.to(() => const GiftCardListScreen());
  }
}
