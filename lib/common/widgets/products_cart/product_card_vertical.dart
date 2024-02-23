import 'package:ethnic_elegance/common/styles/shadows.dart';
import 'package:ethnic_elegance/common/widgets/images/rounded_image.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_title_text.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../custom_shapes/containers/rounded_container.dart';
import '../icons/circular_icon.dart';
import '../texts/product_price_text.dart';

class EProductCardVertical extends StatelessWidget {
  const EProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [EShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(ESizes.productImageRadius),
          color: dark ? EColors.darkerGrey : EColors.white,
        ),
        child: Column(
          children: [

            ///Thumbnail
            ERoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(ESizes.sm),
              backgroundColor: dark ? EColors.dark : EColors.light,
              child: Stack(
                children: [

                  ///Thumbnail Image
                  const ERoundedImage(
                      imageUrl: EImages.onBoardingImage1,
                      applyImageRadius: true),

                  ///sale Tag
                  Positioned(
                    top: 12,
                    child: ERoundedContainer(
                      radius: ESizes.sm,
                      backgroundColor: EColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: ESizes.sm, vertical: ESizes.xs),
                      child: Text('25%',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: EColors.black)),
                    ),
                  ),
                  ///Heart Icon
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: ECircularIcon(
                          icon: Iconsax.heart5, color: Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwItems / 2),

            ///details
            Padding(
              padding: const EdgeInsets.only(left: ESizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EProductTitleText(
                    title: 'Product Title',
                    smallSize: true,
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text('Nike',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelMedium),
                      const SizedBox(height: ESizes.xs),
                      const Icon(Iconsax.verify5,
                          color: EColors.primary, size: ESizes.iconXs)
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            ///Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ///Price
                const Padding(
                  padding: EdgeInsets.only(left: ESizes.sm),
                  child: EProductPriceText(price: '35.0'),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: EColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ESizes.cardRadiusMd),
                        bottomRight:
                        Radius.circular(ESizes.productImageRadius),
                      )),
                  child: const SizedBox(
                      width: ESizes.iconLg * 1.2,
                      height: ESizes.iconLg * 1.2,
                      child: Center(
                        child: Icon(
                          Iconsax.add,
                          color: EColors.white,
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
