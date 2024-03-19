import 'package:ethnic_elegance/common/widgets/icons/brand_title_text_with_verified_iconn.dart';
import 'package:ethnic_elegance/common/widgets/images/circular_image.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_title_text.dart';
import 'package:ethnic_elegance/utils/constants/enums.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class EProductMetaData extends StatelessWidget{
  const EProductMetaData({
    super.key, required this.price, required this.details, required this.name, required this.photo1, required this.photo2, required this.photo3, required this.availability, required this.colour, required this.fabric, required this.size,
});
  final String price,details,name,photo1,photo2,photo3,availability,size,colour,fabric;

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price

        Row(
          children: [
            /// Sale Tag

            // ERoundedContainer(
            //   radius: ESizes.sm,
            //   backgroundColor: EColors.secondary.withOpacity(0.8),
            //   padding: const EdgeInsets.symmetric(horizontal: ESizes.sm, vertical: ESizes.xs),
            //   child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: EColors.black)),
            // ),
            // const SizedBox(width: ESizes.spaceBtwItems),

            ///Price
            // Text('\₹250', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: ESizes.spaceBtwItems),
            EProductPriceText(price: price, isLarge: true),
          ],
        ),
        const SizedBox(width: ESizes.spaceBtwItems / 1.5),

        ///Title
        EProductTitleText(title: name),
        const SizedBox(width: ESizes.spaceBtwItems / 1.5),

        ///Stack Status
        Row(
          children: [
            const EProductTitleText(title: 'Status'),
            const SizedBox(width: ESizes.spaceBtwItems),
            Text(availability, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(width: ESizes.spaceBtwItems / 1.5),

        ///Brand
        Row(
          children: [
            ECircularImage(
              image: EImages.cosmeticsIcon,
              width: 32,
              height: 32,
              overlayColor: darkMode ? EColors.white : EColors.black,
            ),
            EBrandTitleWithVerifiedIcon(title: name, brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}