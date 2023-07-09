import 'package:flutter/material.dart';

import 'constant.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  final VoidCallback? onTap;
  final bool? isValidated;

  final Widget child;
  const CustomButton({
    required this.height,
    required this.width,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.isValidated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isValidated == null || isValidated == false
                    ? [AppColors.mainGradientOne, AppColors.mainGradientTwo]
                    : [
                        Color(0xff00FFBB),
                        Color(0xff2EB200),
                      ])),
        child: child,
      ),
    );
  }
}
