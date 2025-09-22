import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/features/dashboard/controllers/trip_request_cubit.dart';
import 'package:her_driver_app/features/dashboard/widgets/trip_request_card.dart';
import 'package:her_driver_app/features/profile/controllers/profile_controller.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';
import 'package:her_driver_app/features/dashboard/widgets/tier_preferences_card.dart';

class VerifiedDashboardScreen extends StatelessWidget {
  const VerifiedDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimensions.paddingSizeLarge),
              _buildDriverInfo(context, profileController),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              _buildStatusToggle(context, profileController),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              _buildSummaryCard(context, profileController),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              const TierPreferencesCard(),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              _buildQuickActionButtons(context),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              _buildDriverPerformance(context, profileController),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              _buildLatestAnnouncements(context),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              _buildRealTimeTripRequests(context, profileController),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDriverInfo(BuildContext context, ProfileController profileController) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(profileController.profileInfo?.image ?? ''),
        ),
        const SizedBox(width: Dimensions.paddingSizeDefault),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profileController.profileInfo?.name ?? '',
              style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            Text(
              '${'tier'.tr}: ${profileController.profileInfo?.tier ?? ''}',
              style: textRegular.copyWith(color: Theme.of(context).hintColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusToggle(BuildContext context, ProfileController profileController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: profileController.isOnline ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            profileController.isOnline ? 'online'.tr : 'offline'.tr,
            style: textMedium.copyWith(
              color: profileController.isOnline ? Colors.green : Colors.red,
            ),
          ),
          Switch(
            value: profileController.isOnline,
            onChanged: (value) {
              profileController.toggleOnlineStatus();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, ProfileController profileController) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem(context, 'today_s_earnings'.tr, profileController.todayEarnings),
            _buildSummaryItem(context, 'total_trips'.tr, profileController.totalTrips),
            _buildSummaryItem(context, 'average_rating'.tr, profileController.averageRating),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(title, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(value, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
      ],
    );
  }

  Widget _buildQuickActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(context, Icons.edit, 'edit_vehicle'.tr, () {
          Get.to(() => VehicleAddScreen(vehicleInfo: Get.find<ProfileController>().profileInfo?.vehicle));
        }),
        _buildActionButton(context, Icons.add, 'add_new_vehicle'.tr, () {
          Get.to(() => const VehicleAddScreen());
        }),
        _buildActionButton(context, Icons.power_settings_new, 'toggle_active'.tr, () {
          // Add toggle logic here
        }),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Theme.of(context).primaryColor),
          onPressed: onPressed,
        ),
        Text(label, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
      ],
    );
  }

  Widget _buildDriverPerformance(BuildContext context, ProfileController profileController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('driver_performance'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        LinearProgressIndicator(
          value: profileController.tierProgress,
          backgroundColor: Theme.of(context).hintColor.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(
          '${'progress_to_next_tier'.tr}: ${profileController.nextTier}',
          style: textRegular.copyWith(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        _buildBonusCard(context, 'complete_10_trips'.tr, 'get_r50_bonus'.tr),
        _buildBonusCard(context, 'maintain_5_star_rating'.tr, 'get_r100_bonus'.tr),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        _buildGamificationCard(context),
      ],
    );
  }

  Widget _buildGamificationCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: ListTile(
        leading: Icon(Icons.emoji_events, color: Theme.of(context).primaryColor),
        title: Text('vehicle_verification_badge'.tr, style: textMedium),
        subtitle: Text('unlocked_for_completing_setup'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
      ),
    );
  }

  Widget _buildBonusCard(BuildContext context, String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: ListTile(
        leading: Icon(Icons.star, color: Theme.of(context).primaryColor),
        title: Text(title, style: textMedium),
        subtitle: Text(subtitle, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
      ),
    );
  }

  Widget _buildLatestAnnouncements(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('latest_announcements'.tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        // Placeholder for announcements
        Text('no_announcements'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
      ],
    );
  }

Widget _buildRealTimeTripRequests(BuildContext context, ProfileController profileController) {
    return profileController.isOnline
        ? BlocProvider(
            create: (context) => TripRequestCubit(),
            child: BlocBuilder<TripRequestCubit, TripRequestState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.error != null) {
                  return Center(child: Text(state.error!));
                } else if (state.trip != null) {
                  final trip = state.trip!;
                  return TripRequestCard(
                    pickupLocation: trip.pickupLocation,
                    dropoffLocation: trip.dropoffLocation,
                    pickupDistance: trip.pickupDistance,
                    tripDistance: trip.tripDistance,
                    estimatedPickupTime: trip.estimatedPickupTime,
                    vehicleCategory: trip.vehicleCategory,
                    fare: trip.fare,
                    specialRequests: trip.specialRequests,
                    clientRating: trip.clientRating,
                    countdownSeconds: trip.countdownSeconds,
                    onAccept: () {
                      context.read<TripRequestCubit>().acceptTrip(trip.tripId).then((_) {
                        if (trip.otp != null) {
                          Get.to(() => OTPScreen(otp: trip.otp!));
                        }
                      });
                    },
                    onDecline: () {
                      context.read<TripRequestCubit>().declineTrip(trip.tripId);
                    },
                    onPass: () {
                      context.read<TripRequestCubit>().passTrip(trip.tripId);
                    },
                    onBid: (amount) {
                      context.read<TripRequestCubit>().placeBid(trip.tripId, amount);
                    },
                  );
                } else {
                  return Text('no_trip_requests'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor));
                }
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
