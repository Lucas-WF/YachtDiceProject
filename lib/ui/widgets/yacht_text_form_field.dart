import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yatch_project/ui/theme/design_system.dart';

class YachtTextFormField extends StatelessWidget {
  const YachtTextFormField(
      {super.key,
      this.border,
      this.focusedBorder,
      this.isReadOnly,
      this.onFieldSubmitted,
      this.controller,
      this.maxValue,
      required this.height,
      required this.width});

  final void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final OutlineInputBorder? border;
  final OutlineInputBorder? focusedBorder;
  final int? maxValue;
  final bool? isReadOnly;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onFieldSubmitted,
        textInputAction: TextInputAction.send,
        readOnly: isReadOnly ?? false,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        cursorColor: YachtDiceColors.blue,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (maxValue != null) {
              if (newValue.text.isEmpty) {
                return newValue;
              }
              final value = int.parse(newValue.text);
              return value <= maxValue! ? newValue : oldValue;
            }
            return newValue;
          })
        ],
        style: const TextStyle(
            fontSize: 16, height: 1, color: YachtDiceColors.blue),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: YachtDiceColors.white,
          border: border,
          focusedBorder: focusedBorder,
          enabledBorder: border,
          disabledBorder: border,
          errorBorder: border,
        ),
      ),
    );
  }
}
