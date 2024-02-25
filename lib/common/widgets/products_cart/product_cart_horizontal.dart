import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/common/widgets/icons/brand_title_text_with_verified_iconn.dart';
import 'package:ethnic_elegance/common/widgets/images/rounded_image.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_title_text.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../icons/circular_icon.dart';

class EProductCardHorizontal extends StatelessWidget {
  const EProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
          width: 310,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ESizes.productImageRadius),
            color: dark ? EColors.darkerGrey : EColors.softGrey,
          ),
      child: Row(
        children: [
          /// Thumbnoil
          ERoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(ESizes.sm),
            backgroundColor: dark ? EColors.dark : EColors.light,
            child: Stack(
              children: [
                /// Thumbnoil Image
                const SizedBox(
                    width: 120,
                    height: 120,
                    child: ERoundedImage(imageUrl: EImages.productImage2, applyImageRadius: true),
                ),

                ///sale Tag
                Positioned(
                  top: 12,
                  child: ERoundedContainer(
                    radius: ESizes.sm,
                    backgroundColor: EColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: ESizes.sm, vertical: ESizes.xs),
                    child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.black)),
                  ),
                ),

                /// Favourite Icon Button
                const Positioned(
                  top: 0,
                  right: 0,
                  child: ECircularIcon(icon: Iconsax.heart5, color: Colors.red),
                ),
              ],
            ),
          ),

          ///Details
          SizedBox(
            width: 172,
            child:  Padding(
              padding: const EdgeInsets.only(right: ESizes.sm, left: ESizes.sm,),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                    const Column(
                      children: [
                        EProductTitleText(title: 'Green Nike Hlaf Sleeves Shirt', smallSize: true),
                        SizedBox(height: ESizes.spaceBtwItems / 2),
                        EBrandTitleWithVerifiedIcon(title: 'Nike'),
                      ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Pricing
                      const Flexible(child: EProductPriceText(price: '256.0')),

                      ///Add to Cart
                      Container(
                        decoration: const BoxDecoration(
                          color: EColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ESizes.cardRadiusMd),
                            bottomRight: Radius.circular(ESizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: ESizes.iconLg * 1.2,
                          height: ESizes.iconLg * 1.2,
                          child: Center(child: Icon(Iconsax.add, color: EColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}