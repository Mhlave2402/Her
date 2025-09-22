import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/address/domain/models/address_model.dart';
import 'package:her_user_app/features/location/controllers/location_controller.dart';
import 'package:her_user_app/features/location/view/pick_map_screen.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/ride/domain/models/ride_details_model.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';

class LocationInputWidget extends StatelessWidget {
  final LocationType locationType;
  final RideDetails? rideDetails;
  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  final bool isShowCrossButton;
  final String textFieldHint;
  final Function() locationIconTap;

  const LocationInputWidget({
    super.key,
    required this.locationType,
    this.rideDetails,
    this.focusNode,
    required this.textEditingController,
    required this.isShowCrossButton,
    required this.textFieldHint,
    required this.locationIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.circle,
              size: 15,
              color: locationType == LocationType.from
                  ? Theme.of(context).primaryColor
                  : locationType == LocationType.to
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColor.withOpacity(0.5),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
              textInputAction: TextInputAction.search,
              cursorColor: Theme.of(context).hintColor,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: textFieldHint,
                border: InputBorder.none,
                isDense: true,
                hintStyle: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).disabledColor,
                ),
              ),
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  Get.find<LocationController>().searchLocation(context, value, type: locationType);
                }
              },
            ),
          ),
          if (isShowCrossButton)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                textEditingController.clear();
              },
            ),
        ],
      ),
    );
  }
}
