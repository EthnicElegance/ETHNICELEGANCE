import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/common/widgets/images/circular_image.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class EBrandCard extends StatelessWidget{
  const EBrandCard({
    super.key,
    this.onTap,
    required this.showBorder,
});

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {

    final isDark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      ///container design
      child: ERoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ESizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: ECircularImage(
                isNetworkImage: false,
                  image: EImages.clothIcon,
                  backgroundColor: Colors.transparent,
                  overlayColor: isDark ? EColors.white : EColors.black,
            )
            ),
          ],
        ),
      ),
    );

  }
}