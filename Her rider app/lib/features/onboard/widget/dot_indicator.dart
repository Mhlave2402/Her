import 'package:flutter/material.dart';
import 'package:her_user_app/util/dimensions.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.paddingSizeDefault),
        ),
      ),
    );
  }
}
