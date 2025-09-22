import 'package:flutter/material.dart';
import 'package:her_driver_app/util/dimensions.dart';
import 'package:her_driver_app/util/styles.dart';

class TextFieldTitleWidget extends StatelessWidget {
  final String title;
  final double? paddingTop;
  const TextFieldTitleWidget({super.key, required this.title, this.paddingTop});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.fromLTRB(10,paddingTop ?? 17,0,8),
      child: Text(title, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
        color: Theme.of(context).textTheme.bodyMedium!.color!)));
  }
}
