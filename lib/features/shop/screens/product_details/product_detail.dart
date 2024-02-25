import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ethnic_elegance/features/shop/screens/product_reviews/product_reviews.dart';

// import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = EHelperFunctions.isDarkMode(context);
    return  Scaffold(
      bottomNavigationBar: const EBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1-Product Image Slider
            const EProductImageSlider(),

            /// 2- Product Details
            Padding(
              padding: const EdgeInsets.only(right: ESizes.defaultSpace, left: ESizes.defaultSpace, bottom: ESizes.defaultSpace),
              child: Column(
                children: [
                  /// Rating & Share Button
                  const ERatingAndShare(),

                  /// Price, Title, Stock & Brand
                  const EProductMetaData(),

                  /// Attributes
                  const EProductAttributes(),
                  const SizedBox(height: ESizes.spaceBtwSections),

                  /// Checkout Button
                  SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () {}, child: const Text('Checkout'))),
                  const SizedBox(height: ESizes.spaceBtwSections),

                  /// Description
                  const ESectionHeading(title: 'Description', showActionButton: false,),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  const ReadMoreText(
                    'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// Reviews
                  const Divider(),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ESectionHeading(title: 'Reviews(199)',showActionButton: false),
                      IconButton(icon: const Icon(Iconsax.arrow_right_3,size: 18),onPressed: () => Get.to(() => const ProductReviewsScreen())),
                    ],
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


