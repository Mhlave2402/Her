import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';

class TypeButtonWidget extends StatelessWidget {
  final int index;
  final String name;
  final Function()? onTap;
  final int selectedIndex;
  final double? cardWidth;
  const TypeButtonWidget({super.key, required this.index, required this.name, this.onTap, required this.selectedIndex, this.cardWidth});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
          child: Container(width: cardWidth,
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
              border: Border.all(width: .5, color: index == selectedIndex ? Theme.of(context).colorScheme.onSecondary: Theme.of(context).primaryColor),
              color: index == selectedIndex? Theme.of(context).primaryColor : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment : CrossAxisAlignment.center,children: [
                Text(name.tr,overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textSemiBold.copyWith(
                      color : index == selectedIndex ?
                      Colors.white :
                      Theme.of(context).hintColor.withValues(alpha: .65),
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}