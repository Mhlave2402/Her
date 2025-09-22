import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/wallet/controllers/wallet_controller.dart';
import 'package:her_user_app/features/wallet/widget/loyalty_point_card.dart';
import 'package:her_user_app/features/wallet/widget/loyalty_point_help_widget.dart';
import 'package:her_user_app/features/wallet/widget/wallet_money_amount_widget.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';
import 'package:her_user_app/features/notification/widgets/notification_shimmer.dart';
import 'package:her_user_app/features/wallet/widget/custom_title.dart';
import 'package:her_user_app/common_widgets/no_data_widget.dart';
import 'package:her_user_app/common_widgets/paginated_list_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class LoyaltyPointScreen extends StatefulWidget {
  const LoyaltyPointScreen({super.key});

  @override
  State<LoyaltyPointScreen> createState() => _LoyaltyPointScreenState();
}

class _LoyaltyPointScreenState extends State<LoyaltyPointScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (walletController) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('loyalty_point'.tr,
                style: textBold.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: Dimensions.fontSizeLarge)),
            InkWell(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => const LoyaltyPointHelpWidget(),
                );
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('how_it_works'.tr,
                    style: textRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withValues(alpha: 0.9))),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                const Icon(Icons.help_outline, size: 16)
              ]),
            ),
          ]),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        const WalletMoneyAmountWidget(),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipPadding: EdgeInsets.zero,
                  tooltipMargin: 8,
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      rod.toY.round().toString(),
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];
                      final Widget text = Text(
                        titles[value.toInt()],
                        style: const TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 16, //margin top
                        child: text,
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: walletController.loyaltyPointModel != null
                  ? walletController.loyaltyPointModel!.data!
                      .map((point) => BarChartGroupData(
                            x: walletController.loyaltyPointModel!.data!.indexOf(point),
                            barRods: [
                              BarChartRodData(
                                toY: point.credit!.toDouble(),
                                color: Colors.lightBlueAccent,
                              )
                            ],
                            showingTooltipIndicators: [0],
                          ))
                      .toList()
                  : [],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: CustomTitle(
              title: 'point_history'.tr,
              color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Divider(thickness: .125),
        ),
        Expanded(
          child: walletController.loyaltyPointModel?.data != null
              ? (walletController.loyaltyPointModel!.data!.isNotEmpty)
                  ? SingleChildScrollView(
                      controller: scrollController,
                      child: PaginatedListWidget(
                        scrollController: scrollController,
                        totalSize:
                            walletController.loyaltyPointModel!.totalSize,
                        offset: (walletController.loyaltyPointModel?.offset !=
                                null)
                            ? int.parse(walletController
                                .loyaltyPointModel!.offset
                                .toString())
                            : null,
                        onPaginate: (int? offset) async {
                          await walletController.getTransactionList(offset!);
                        },
                        itemView: ListView.builder(
                          itemCount:
                              walletController.loyaltyPointModel!.data!.length,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return LoyaltyPointCard(
                                points: walletController
                                    .loyaltyPointModel!.data![index]);
                          },
                        ),
                      ))
                  : const NoDataWidget(title: 'no_point_gain_yet')
              : const NotificationShimmer(),
        ),
      ]);
    });
  }
}
