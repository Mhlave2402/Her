import 'package:flutter/material.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/styles.dart';


class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool fillColor;
  final Function(String) onChanged;
  final FocusNode? focusNode;
  const CustomSearchField({super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
     this.fillColor = false,
     this.focusNode,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textInputAction: TextInputAction.search,
          enabled: true,
          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyMedium!.color),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyMedium!.color!.withValues(alpha: 0.5)),
            filled: widget.fillColor,
            fillColor: Theme.of(context).cardColor,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            focusedBorder:const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0)),

          ),
          onChanged: widget.onChanged,

        ),
      ),
    ],);
  }
}
