import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/address/controllers/address_controller.dart';
import 'package:her_user_app/features/address/domain/models/address_model.dart';
import 'package:her_user_app/features/location/controllers/location_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';

class RecentTripsWidget extends StatelessWidget {
  const RecentTripsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(builder: (addressController) {
      return (addressController.addressList != null && addressController.addressList!.isNotEmpty)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Text(
                    'Recent Trips',
                    style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                  ),
                ),
                _buildAddressCategory(
                  context,
                  'Saved Places',
                  addressController.addressList!
                      .where((address) =>
                          address.addressLabel == 'home' || address.addressLabel == 'office')
                      .toList(),
                ),
                _buildAddressCategory(
                  context,
                  'Frequently Visited',
                  addressController.addressList!
                      .where((address) =>
                          address.addressLabel != 'home' && address.addressLabel != 'office')
                      .toList(),
                ),
              ],
            )
          : const SizedBox();
    });
  }

  Widget _buildAddressCategory(BuildContext context, String title, List<Address> addresses) {
    return addresses.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Text(
                  title,
                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.find<LocationController>().setDestination(addresses[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                      child: Row(
                        children: [
                          Icon(
                            addresses[index].addressLabel == 'home'
                                ? Icons.home
                                : addresses[index].addressLabel == 'office'
                                    ? Icons.work
                                    : Icons.location_on,
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Expanded(
                            child: Text(
                              addresses[index].address!,
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        : const SizedBox();
  }
}
