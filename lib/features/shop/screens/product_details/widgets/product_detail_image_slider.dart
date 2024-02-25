import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ethnic_elegance/common/widgets/icons/circular_icon.dart';
// import 'package:ethnic_elegance/common/widgets/images/rounded_image.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
// import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/helpers/helper_functions.dart';


class EProductImageSlider extends StatelessWidget {
  const EProductImageSlider({
    super.key, required this.image1, required this.image2, required this.image3,

  });
final String image1,image2,image3;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return ECurvedEdgeWidget(
      child: Container(
        color: dark ? EColors.darkerGrey : EColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                  padding:
                  const EdgeInsets.all(ESizes.productImageRadius * 2),
                  child: Center(
                      child: Image(
                          image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F$image1?alt=media")))),
            ),

            ///Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: ESizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(width: ESizes.spaceBtwItems),
                  itemCount: 1,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 80,
                      padding: const EdgeInsets.all(ESizes.sm),
                      decoration: BoxDecoration(
                        border: Border.all(color: EColors.primary),
                        color: dark ? EColors.dark : EColors.white,
                        borderRadius: BorderRadius.circular(ESizes.md),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(ESizes.md),
                        child: Image(
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F$image2?alt=media"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    )
                  )
                ),
              ),

            ///AppBar Icons
            const EAppBar(
              showBackArrow: true,
              actions: [
                ECircularIcon(icon: Iconsax.heart5, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}