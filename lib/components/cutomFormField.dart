import 'package:flutter/material.dart';

import 'constant.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final String label;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool isValid = false;

  final Function(String)? onFieldSubmitted;
  // required this.onFieldSubmitted

  const CustomFormField(
      {super.key,
      required this.textController,
      required this.focusNode,
      required this.validator,
      required this.label,
      required this.prefixIcon,
      this.suffixIcon,
      this.onFieldSubmitted,
      this.obscureText

      // this.obscureText,
      });

  // const CustomFormField({super.key});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // scrollPadding: EdgeInsets.all(10),
      style: TextStyle(fontSize: 12),

      controller: widget.textController,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          label: Text(
            widget.label,
            style: TextStyle(
              color: widget.focusNode.hasFocus
                  ? AppColors.authFocusedBorderColor
                  : AppColors.authBasicColor,
              // fontSize: 12,
              // fontFamily: 'RobotoSlab',
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.authFocusedBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
