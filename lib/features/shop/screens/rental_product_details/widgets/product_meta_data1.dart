import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_title_text.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';

class EProductMetaData1 extends StatelessWidget{
  const EProductMetaData1({
    super.key, required this.price, required this.details, required this.name, required this.photo1, required this.photo2, required this.photo3, required this.availability, required this.colour, required this.fabric, required this.size,
});
  final String price,details,name,photo1,photo2,photo3,availability,size,colour,fabric;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price

        Row(
          children: [
            const SizedBox(width: ESizes.spaceBtwItems),
            EProductPriceText(price: price, isLarge: true),
          ],
        ),
        const SizedBox(width: ESizes.spaceBtwItems / 1.5),

        ///Title
        EProductTitleText(title: name),
        const SizedBox(width: ESizes.spaceBtwItems / 1.5),

        ///Stack Status
        // Row(
        //   children: [
        //     const EProductTitleText(title: 'Status'),
        //     const SizedBox(width: ESizes.spaceBtwItems),
        //     Text(availability, style: Theme.of(context).textTheme.titleMedium),
        //   ],
        // ),
        const SizedBox(width: ESizes.spaceBtwItems / 1.5),

        ///Brand
        // Row(
        //   children: [
        //     ECircularImage(
        //       image: EImages.cosmeticsIcon,
        //       width: 32,
        //       height: 32,
        //       overlayColor: darkMode ? EColors.white : EColors.black,
        //     ),
        //     EBrandTitleWithVerifiedIcon(title: name, brandTextSize: TextSizes.medium),
        //   ],
        // ),
      ],
    );
  }
}