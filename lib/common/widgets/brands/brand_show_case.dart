import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';


class EBrandShoeCase extends StatelessWidget {
  const EBrandShoeCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return ERoundedContainer(
      showBorder: true,
      borderColor: EColors.darkerGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(ESizes.md),
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
      child: Column(
        children: [
          const EBrandCard(showBorder: false),
          const SizedBox(height: ESizes.spaceBtwItems),

          ///Brand Top # Product Images
          Row(children: images.map((image) => brandTopProductImageWidget(image, context)).toList(),

          ),
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, conext)
  {
    return Expanded(
      child: ERoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(ESizes.md),
        margin: const EdgeInsets.only(right: ESizes.sm),
        backgroundColor: EHelperFunctions.isDarkMode(conext) ? EColors.darkerGrey : EColors.light,
        child:  Image(fit: BoxFit.contain, image: AssetImage(image)),
      ),
    );
  }

}