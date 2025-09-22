import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/auth/controllers/auth_controller.dart';
import 'package:her_driver_app/features/map/widgets/trip_accept_warning_dialog_widget.dart';
import 'package:her_driver_app/helper/date_converter.dart';
import 'package:her_driver_app/helper/display_helper.dart';
import 'package:her_driver_app/util/app_constants.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/images.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:her_driver_app/features/map/controllers/map_controller.dart';
import 'package:her_driver_app/features/map/screens/map_screen.dart';
import 'package:her_driver_app/features/map/widgets/bid_accepting_dialog_widget.dart';
import 'package:her_driver_app/features/map/widgets/bidding_dialog_widget.dart';
import 'package:her_driver_app/features/map/widgets/customer_info_widget.dart';
import 'package:her_driver_app/features/map/widgets/route_widget.dart';
import 'package:her_driver_app/features/ride/controllers/ride_controller.dart';
import 'package:her_driver_app/features/ride/domain/models/trip_details_model.dart';
import 'package:her_driver_app/features/splash/controllers/splash_controller.dart';
import 'package:her_driver_app/features/trip/screens/payment_received_screen.dart';
import 'package:her_driver_app/features/trip/screens/review_this_customer_screen.dart';
import 'package:her_driver_app/common_widgets/confirmation_dialog_widget.dart';
import 'package:her_driver_app/common_widgets/button_widget.dart';

class CustomerRideRequestCardWidget extends StatelessWidget {
  final TripDetail rideRequest;
  final bool fromList;
  final bool fromParcel;
  final int? index;
  const CustomerRideRequestCardWidget({
    super.key, required this.rideRequest,
    this.fromList = false,
    this.fromParcel = false, this.index
  });

  @override
  Widget build(BuildContext context) {

    return !fromList ?
    GetBuilder<RideController>(builder: (rideController) {
      return InkWell(
        onTap: (){
          if(fromParcel){
            Get.find<RiderMapController>().setRideCurrentState(RideState.ongoing);
            Get.find<RideController>().getRideDetails(rideRequest.id!).then((value){
              if(value.statusCode == 200){
                Get.find<RideController>().updateRoute(false, notify: true);
                Get.to(() => const MapScreen(fromScreen: 'splash'));
              }
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(color: Theme.of(Get.context!).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
              border: Border.all(color: Theme.of(Get.context!).primaryColor,width: .35),
              boxShadow:[BoxShadow(
                color: Theme.of(Get.context!).primaryColor.withValues(alpha: .1),
                blurRadius: 1, spreadRadius: 1, offset: const Offset(0,0),
              )],
            ),
            child: Column(children: [
              _CommonDesignPart(rideRequest: rideRequest),

              fromParcel ?
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall,
                  Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,
                ),
                child: SizedBox(width: 250,
                  child: Row(children: [
                    Expanded(child: ButtonWidget(
                      buttonText: 'complete'.tr,
                      radius: Dimensions.paddingSizeSmall,
                      onPressed: () async{
                        if(rideRequest.paymentStatus == 'paid'){
                          Get.dialog(barrierDismissible: false,
                              ConfirmationDialogWidget(
                                icon: Images.logOutIcon,
                                description: 'are_you_sure'.tr,
                                onYesPressed: () {
                                  if(Get.find<RideController>().matchedMode != null &&
                                      (Get.find<RideController>().matchedMode!.distance! * 1000)
                                          <= Get.find<SplashController>().config!.completionRadius!){
                                    Get.find<RideController>().tripStatusUpdate(
                                      'completed', rideRequest.id!,
                                      "trip_completed_successfully", '',
                                    ).then((value) async {
                                      if(value.statusCode == 200){
                                        if(Get.find<SplashController>().config!.reviewStatus!){
                                          Get.offAll(()=> ReviewThisCustomerScreen(tripId: rideRequest.id!));
                                        }else{
                                          Get.find<RiderMapController>().setRideCurrentState(RideState.initial);
                                          Get.off(()=> const DashboardScreen());
                                        }
                                      }
                                    });
                                  }else{
                                    Get.back();
                                    showCustomSnackBar("you_are_not_reached_destination".tr,);
                                  }
                                },
                              ));
                        }else{
                          if(rideRequest.parcelInformation!.payer == 'sender') {
                            rideController.tripStatusUpdate(
                              'completed', rideRequest.id!,
                              "trip_completed_successfully",'',
                            ).then((value) async {
                              rideController.getFinalFare(rideRequest.id!).then((value) {
                                if(value.statusCode == 200){
                                  if(Get.find<SplashController>().config!.reviewStatus!){
                                    Get.offAll(()=>  ReviewThisCustomerScreen(
                                      tripId: rideController.tripDetail!.id!,
                                    ));
                                  }else{
                                    Get.offAll(()=> const DashboardScreen());
                                  }
                                }
                              });
                            });
                          }
                          else{
                            if(Get.find<RideController>().matchedMode != null &&
                                (Get.find<RideController>().matchedMode!.distance! * 1000) <=
                                    Get.find<SplashController>().config!.completionRadius!){
                              rideController.tripStatusUpdate(
                                'completed', rideRequest.id!,
                                "trip_completed_successfully",'',
                              ).then((value) async {
                                if(value.statusCode == 200){
                                  Get.find<RideController>().getFinalFare(rideRequest.id!).then((value){
                                    if(value.statusCode == 200){
                                      Get.find<RiderMapController>().setRideCurrentState(RideState.initial);
                                      Get.to(()=> const PaymentReceivedScreen());
                                    }
                                  });
                                }
                              });
                            }else{
                              showCustomSnackBar("you_are_not_reached_destination".tr,);
                            }
                          }
                        }
                      },
                    )),
                  ]),
                ),
              ) :
              GetBuilder<RideController>(builder: (rideController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,
                    vertical: Dimensions.paddingSizeDefault,
                  ),
                  child: rideController.accepting ?
                  SpinKitCircle(color: Theme.of(context).primaryColor, size: 40.0) :
                  Row(children: [
                    Expanded(child: ButtonWidget(
                      buttonText:  _isShowBidButton(rideRequest) ?
                      'bid'.tr :
                      'reject'.tr,
                      transparent: true,
                      borderWidth: 1,
                      showBorder: _isShowBidButton(rideRequest) ? true : false,
                      radius: Dimensions.paddingSizeSmall,
                      borderColor: Theme.of(Get.context!).primaryColor,
                      backgroundColor: _isShowBidButton(rideRequest) ? null : Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                      textColor: _isShowBidButton(rideRequest) ? null : Theme.of(context).colorScheme.error,
                      onPressed: (){
                        if(_isShowBidButton(rideRequest)){
                          showDialog(
                            context: Get.context!,
                            builder: (_)=>  BiddingDialogWidget(rideRequest: rideRequest),
                          );
                        }else{
                          rideController.tripAcceptOrRejected(
                            rideRequest.id!, 'rejected',
                            rideRequest.type ?? '',
                            rideRequest.parcelInformation?.weight ?? '0',
                          ).then((value) async {
                            if(value.statusCode == 200){
                              Get.offAll(()=> const DashboardScreen());
                              Get.find<RiderMapController>().setRideCurrentState(RideState.initial);
                            }
                          });
                        }
                      },
                    )),
                    const SizedBox(width : Dimensions.paddingSizeLarge),

                    Expanded(child:  ButtonWidget(
                      buttonText: 'accept'.tr,
                      radius: Dimensions.paddingSizeSmall,
                      onPressed: () async{
                        rideController.tripAcceptOrRejected(
                          rideRequest.id!,
                          'accepted',rideRequest.type ?? '',
                          rideRequest.parcelInformation?.weight ?? '0',
                        ).then((value) async {
                          if(value.statusCode == 200){
                            Get.find<AuthController>().saveRideCreatedTime();
                            if(rideRequest.type == AppConstants.scheduleRequest){
                              Get.find<RiderMapController>().setRideCurrentState(RideState.accepted);
                            }else{
                              Get.find<RiderMapController>().setRideCurrentState(RideState.outForPickup);
                            }

                            Get.find<RideController>().updateRoute(false, notify: true);
                            Get.find<RideController>().remainingDistance(rideRequest.id!,mapBound: true);
                            Get.find<RideController>().getPendingRideRequestList(1);
                            Get.to(()=> const MapScreen());
                          }else{
                             Get.dialog(TripAcceptWarningDialogWidget(errorText: value.body['message']));
                          }
                        });
                      },
                    )),
                  ]),
                );
              }),
            ]),
          ),
        ),
      );
    }) :
    Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: false,
        children:  [
          SlidableAction(
            onPressed: (value){
              Get.find<RideController>().tripAcceptOrRejected(
                rideRequest.id!, 'rejected',rideRequest.type ?? '',
                rideRequest.parcelInformation?.weight ?? '0',
              ).then((value){
                if(value.statusCode == 200){
                  Get.find<RideController>().getPendingRideRequestList(1);
                  if(fromList){
                    Get.find<RiderMapController>().setRideCurrentState(RideState.initial);
                  }
                }
              });
            },
            backgroundColor: Theme.of(context).colorScheme.error.withValues(alpha: .2),
            foregroundColor: Theme.of(context).colorScheme.error,
            icon: Icons.delete_forever_rounded,
            label: 'reject'.tr,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall,
        ),
        child: Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(color: Theme.of(Get.context!).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
            border: Border.all(color: Theme.of(Get.context!).primaryColor,width: .35),
            boxShadow:[BoxShadow(
              color: Theme.of(Get.context!).primaryColor.withValues(alpha: .1),
              blurRadius: 1, spreadRadius: 1, offset: const Offset(0,0),
            )],
          ),
          child: Column(children: [
            _CommonDesignPart(rideRequest: rideRequest),

            GetBuilder<RideController>(builder: (rideController) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeDefault,
                ),
                child: rideController.pendingRideRequestModel!.data![index!].id == rideController.onPressedTripId && rideController.accepting ?
                SpinKitCircle(color: Theme.of(context).primaryColor, size: 40.0) :
                Row(children: [
                  Expanded(child: ButtonWidget(
                    buttonText: _isShowBidButton(rideRequest)  ?
                    'bid'.tr : 'reject'.tr,
                    transparent: true,
                    borderWidth: 1,
                    showBorder: _isShowBidButton(rideRequest) ? true : false,
                    radius: Dimensions.paddingSizeSmall,
                    borderColor: Theme.of(Get.context!).primaryColor,
                    backgroundColor: _isShowBidButton(rideRequest) ? null : Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                    textColor: _isShowBidButton(rideRequest) ? null : Theme.of(context).colorScheme.error,
                    onPressed: (){
                      if(_isShowBidButton(rideRequest) ){
                        showDialog(
                          context: Get.context!,
                          builder: (_)=>  BiddingDialogWidget(rideRequest: rideRequest),
                        );
                      }else{
                        Get.find<RideController>().tripAcceptOrRejected(
                          rideRequest.id!, 'rejected',
                          rideRequest.type ?? '',
                          rideRequest.parcelInformation?.weight ?? '0',
                        ).then((value){
                          if(value.statusCode == 200){
                            Get.find<RideController>().getPendingRideRequestList(1);
                            if(fromList){
                              Get.find<RideController>().ongoingTripList().then((value) async {
                                if((Get.find<RideController>().ongoingTrip ?? []).isEmpty){
                                  Get.find<RiderMapController>().setRideCurrentState(RideState.initial);

                                }else{
                                  Get.back(closeOverlays: true);
                                }

                              });

                            }
                          }
                        });
                      }
                    },
                  )),
                  const SizedBox(width: Dimensions.paddingSizeLarge),

                  Expanded(child: ButtonWidget(
                    buttonText: 'accept'.tr,
                    radius: Dimensions.paddingSizeSmall,
                    onPressed: () async{
                      Get.find<RideController>().tripAcceptOrRejected(
                          rideRequest.id!, 'accepted',
                          rideRequest.type ?? '',
                          rideRequest.parcelInformation?.weight ?? '0',
                          showSuccess: false
                      ).then((value) {
                        if(value.statusCode == 200){
                          Get.find<RideController>().ongoingTripList().then((value) async {
                            if((Get.find<RideController>().ongoingTrip ?? []).length <= 1){
                              if(value.statusCode == 200){
                                Get.find<AuthController>().saveRideCreatedTime();
                                if(fromList){
                                  Get.find<RideController>().getRideDetails(rideRequest.id!).then((value) async {
                                    if(value.statusCode == 200){
                                      if(rideRequest.type == AppConstants.scheduleRequest){
                                        Get.find<RiderMapController>().setRideCurrentState(RideState.accepted);
                                      }else{
                                        Get.find<RiderMapController>().setRideCurrentState(RideState.outForPickup);
                                      }
                                      Get.find<RideController>().updateRoute(false, notify: true);
                                      Get.to(()=> const MapScreen());
                                    }
                                  });
                                }else{
                                  Get.dialog(const BidAcceptingDialogueWidget(), barrierDismissible: false);
                                  await Future.delayed( const Duration(seconds: 5));
                                  Get.back();
                                  if(rideRequest.type == AppConstants.scheduleRequest){
                                    Get.find<RiderMapController>().setRideCurrentState(RideState.accepted);
                                  }else{
                                    Get.find<RiderMapController>().setRideCurrentState(RideState.outForPickup);
                                  }
                                  Get.to(()=> const MapScreen());
                                }
                              }

                            }else{
                              Get.back();
                              showCustomSnackBar('you_accept_the_request'.tr, isError: false, subMessage: 'after_complete_the_ongoing_trip'.tr);
                              Get.find<RideController>().getPendingRideRequestList(1);
                            }

                          });

                        }else{
                           Get.dialog(TripAcceptWarningDialogWidget(errorText: value.body['message']));
                        }

                      });
                    },
                  )),
                ]),
              );
            }),
          ]),
        ),
      ),
    );
  }
}

bool _isShowBidButton(TripDetail rideRequest){
  bool bidOn = Get.find<SplashController>().config!.bidOnFare!;

  return (bidOn && rideRequest.type == 'ride_request' &&
      rideRequest.fareBiddings != null &&
      rideRequest.fareBiddings!.isEmpty);
}

class _CommonDesignPart extends StatelessWidget {
  final TripDetail rideRequest;
  const _CommonDesignPart({required this.rideRequest});

  @override
  Widget build(BuildContext context) {

    String firstRoute = '';
    String secondRoute = '';
    List<dynamic> extraRoute = [];
    if(rideRequest.intermediateAddresses != null && rideRequest.intermediateAddresses != '[[, ]]'){
      extraRoute = jsonDecode(rideRequest.intermediateAddresses!);
      if(extraRoute.isNotEmpty){
        firstRoute = extraRoute[0];
      }
      if(extraRoute.isNotEmpty && extraRoute.length>1){
        secondRoute = extraRoute[1];
      }
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'trip_type'.tr,
            style: textBold,
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall,
              vertical: Dimensions.paddingSizeExtraSmall,
            ),
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
            ),
            child: Text(
              rideRequest.type!.tr,
              style: textRegular.copyWith(color: Theme.of(Get.context!).cardColor),
            ),
          ),
        ]),
      ),

      if(rideRequest.type == 'scheduled_request')
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
          ),
          padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('pickup_date_time'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

            Text(DateConverter.tripDetailsShowFormat(rideRequest.scheduledAt ?? ''), style: textSemiBold.copyWith(
              fontSize: Dimensions.fontSizeSmall,
            ))
          ]),
        )
      else
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
          ),
          padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
              Image.asset(Images.circularClockIcon, height: 12, width: 12),

              Text('${rideRequest.estimatedTime} ${'min_away'.tr}', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))
            ]),

            Text('${'distance'.tr}: ${rideRequest.estimatedDistance?.toStringAsFixed(2)} Km', style: textRegular.copyWith(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7), fontSize: Dimensions.fontSizeSmall,
            ))
          ]),
        ),
      const SizedBox(height: Dimensions.paddingSizeSmall),

      if(rideRequest.type == 'scheduled_request' && (DateConverter.findTimeDifference(rideRequest.scheduledAt ?? '') > 0))...[
        Text(
          '${'your_pickup_time_start'.tr} ${DateConverter.getMinutesToDayHourMinutes(DateConverter.findTimeDifference(rideRequest.scheduledAt ?? ''))} ${'from_now'.tr}',
          style: textRegular.copyWith(color: Theme.of(context).colorScheme.surfaceContainer),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ],

      RouteWidget(
        fromCard: true,
        pickupAddress: rideRequest.pickupAddress!,
        destinationAddress: rideRequest.destinationAddress!,
        extraOne: firstRoute, extraTwo: secondRoute, entrance: rideRequest.entrance??'',
      ),

      if(rideRequest.customer != null)
        CustomerInfoWidget(
          fromTripDetails: false,
          customer: rideRequest.customer!, fare: rideRequest.estimatedFare!,
          customerRating: rideRequest.customerAvgRating!,
        ),

      if(rideRequest.isChildFriendly ?? false)
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Row(children: [
            Icon(Icons.child_friendly, color: Theme.of(context).primaryColor, size: 20),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text('child_friendly_ride'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
          ]),
        ),

      Get.find<RideController>().matchedMode != null ?
      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Row(children: [
          Icon(Icons.arrow_forward_outlined,
            color: Theme.of(Get.context!).primaryColor,
            size: Dimensions.iconSizeMedium,
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Row(children: [
            Text(
              Get.find<RideController>().matchedMode!.duration!,
              style: textRegular.copyWith(color: Theme.of(Get.context!).primaryColor),
            ),

            Text(
              ' ${'pickup_time'.tr}',
              style: textRegular.copyWith(color: Theme.of(Get.context!).textTheme.bodyMedium?.color),
            )
          ]),
        ]),
      ) :
      const SizedBox(),
    ]);
  }
}
