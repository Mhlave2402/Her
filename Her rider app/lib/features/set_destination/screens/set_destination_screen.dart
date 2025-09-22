import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/ride/screens/choose_vehicle_screen.dart';
import 'package:her_user_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:her_user_app/features/parcel/controllers/parcel_controller.dart';
import 'package:her_user_app/features/ride/widgets/trip_features_widget.dart';
import 'package:her_user_app/features/set_destination/widget/location_input_widget.dart';
import 'package:her_user_app/features/set_destination/widget/pickup_time_date_widget.dart';
import 'package:her_user_app/features/set_destination/widget/recent_trips_widget.dart';
import 'package:her_user_app/features/set_destination/widget/process_button_widget.dart';
import 'package:her_user_app/features/set_destination/widget/reservation_note_widget.dart';
import 'package:her_user_app/helper/route_helper.dart';
import 'package:her_user_app/localization/localization_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/images.dart';
import 'package:her_user_app/util/styles.dart';
import 'package:her_user_app/features/address/domain/models/address_model.dart';
import 'package:her_user_app/features/location/controllers/location_controller.dart';
import 'package:her_user_app/features/location/view/pick_map_screen.dart';
import 'package:her_user_app/features/map/controllers/map_controller.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/features/splash/controllers/config_controller.dart';
import 'package:her_user_app/common_widgets/trip_setup_scaffold.dart';
import 'package:her_user_app/common_widgets/divider_widget.dart';
import 'dart:math' as math;
import 'package:her_user_app/features/address/controllers/address_controller.dart';

class SetDestinationScreen extends StatefulWidget {
  final Address? address;
  final String? searchText;
  final RideType rideType;
  const SetDestinationScreen({super.key, this.address,this.searchText, this.rideType = RideType.regularRide});

  @override
  State<SetDestinationScreen> createState() => _SetDestinationScreenState();
}

class _SetDestinationScreenState extends State<SetDestinationScreen> {
  FocusNode pickLocationFocus = FocusNode();
  FocusNode destinationLocationFocus = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Get.find<RideController>().setRideType(widget.rideType);
    Get.find<LocationController>().initAddLocationData();
    Get.find<LocationController>().initTextControllers();
    Get.find<RideController>().clearExtraRoute();
    Get.find<MapController>().initializeData();
    Get.find<RideController>().initData();
    Get.find<ParcelController>().updatePaymentPerson(false, notify: false);
    Get.find<LocationController>().setPickUp(Get.find<LocationController>().getUserAddress());
    Get.find<AddressController>().getAddressList(1);
    if(widget.address != null) {
      Get.find<LocationController>().setDestination(widget.address);
    }
    if(widget.searchText != null){
      Get.find<LocationController>().setDestination(Address(address: widget.searchText));
      Future.delayed(const Duration(seconds: 1)).then((_){
        Get.find<LocationController>().searchLocation(Get.context!, widget.searchText ?? '', type: LocationType.to);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return TripSetupScaffold(
        child: GetBuilder<LocationController>(builder: (locationController) {
          if (locationController.resultShow) {
            scrollController.jumpTo(MediaQuery.of(context).size.height + MediaQuery.of(context).viewInsets.bottom);
          }

            return Stack(clipBehavior: Clip.none, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall,
                ),
                child: SingleChildScrollView(controller: scrollController, child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,children: [
                  const TripFeaturesWidget(),
                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  PickupTimeDateWidget(),

                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  _buildLocationInput(locationController, rideController),

                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  const RecentTripsWidget(),
                  if(rideController.rideType == RideType.scheduleRide)
                    ReservationNoteWidget(),

                  if(rideController.rideType == RideType.scheduleRide)
                    ReservationNoteWidget(),

                  if(locationController.resultShow)
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                ])),
              ),

              if(locationController.resultShow)
                Positioned(
                  top: 0, left: 0, right: 0,
                  child: InkWell(
                    onTap: () => locationController.setSearchResultShowHide(show: false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ?
                        Theme.of(context).canvasColor :
                        Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                      ),
                      margin: EdgeInsets.fromLTRB(30, locationController.topPosition, 30, 0),
                      child: ListView.builder(
                        itemCount: locationController.predictionList?.data?.suggestions?.length ?? 0,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return  InkWell(
                            onTap: () {
                              Get.find<LocationController>().setLocation(
                                fromSearch: true,
                                locationController.predictionList?.data?.suggestions?[index].placePrediction?.placeId ?? '',
                                locationController.predictionList?.data?.suggestions?[index].placePrediction?.text?.text ?? '', null,
                                type: locationController.locationType,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeDefault,
                                horizontal: Dimensions.paddingSizeSmall,
                              ),
                              child: Row(children: [
                                const Icon(Icons.location_on),

                                Expanded(child: Text(
                                  locationController.predictionList?.data?.suggestions?[index].placePrediction?.text?.text ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                )),
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ) ,
            ]);
        }),
      );
    });
  }
  
  Widget _buildLocationInput(LocationController locationController, RideController rideController) {
    return Column(
      children: [
        LocationInputWidget(
          focusNode: pickLocationFocus,
          textEditingController: locationController.fromController,
          locationIconTap: () {
            locationController.setSearchResultShowHide(show: true, type: LocationType.from);
          },
          locationType: LocationType.from,
          isShowCrossButton: true,
          textFieldHint: 'from'.tr,
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        LocationInputWidget(
          focusNode: destinationLocationFocus,
          textEditingController: locationController.toController,
          locationIconTap: () {
            locationController.setSearchResultShowHide(show: true, type: LocationType.to);
          },
          locationType: LocationType.to,
          isShowCrossButton: true,
          textFieldHint: 'to'.tr,
        ),
      ],
    );
  }
}

class _LocationFromToWidget extends StatelessWidget {
  const _LocationFromToWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,Dimensions.paddingSizeLarge, 0, 0),
      child: Column(children: [
        SizedBox(
          width: Dimensions.iconSizeLarge,
          child: Image.asset(
            Images.currentLocation,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),

        SizedBox(height: 60, width: 10, child: CustomDivider(
          height: 5, dashWidth: .75,
          axis: Axis.vertical,
          color: Theme.of(context).textTheme.bodyMedium!.color!.withValues(alpha: 0.5),
        )),

        SizedBox(
          width: Dimensions.iconSizeMedium,
          child: Transform(
            alignment: Alignment.center,
            transform: Get.find<LocalizationController>().isLtr ?
            Matrix4.rotationY(0) :
            Matrix4.rotationY(math.pi),
            child: Image.asset(
              Images.activityDirection,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        ),
      ]),
    );
  }
}
