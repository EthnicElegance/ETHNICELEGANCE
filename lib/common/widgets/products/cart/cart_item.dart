import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/brand_title_text_with_verified_iconn.dart';
import '../../images/rounded_image.dart';
import '../../texts/product_title_text.dart';

class ECartItem extends StatelessWidget {
  const ECartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //image
        ERoundedImage(
          imageUrl: EImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(ESizes.sm),
          backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.darkerGrey : EColors.light,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),

        //title , price & size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EBrandTitleWithVerifiedIcon(title: "Nike"),
              const Flexible(child: EProductTitleText(title: "Black Sports Shoes ", maxLines: 1,)),

              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: "Color ", style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: "Green ", style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(text: "Size ", style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: "7 ", style: Theme.of(context).textTheme.bodyLarge),
                      ]
                  )
              )

            ],
          ),
        )
      ],
    );
  }
}
