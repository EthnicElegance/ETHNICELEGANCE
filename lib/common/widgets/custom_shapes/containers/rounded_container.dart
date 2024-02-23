import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class ERoundedContainer extends StatelessWidget {
  const ERoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = ESizes.cardRadiusLg,
    this.padding,
    this.margin,
    this.child,
    this.backgroundColor = EColors.white,
    this.showBorder = false,
    this.borderColor = EColors.borderPrimary,
  });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
