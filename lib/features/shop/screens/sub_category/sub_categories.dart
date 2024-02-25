import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/images/rounded_image.dart';
import 'package:ethnic_elegance/common/widgets/products_cart/product_cart_horizontal.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget{
  const SubCategoriesScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EAppBar(title: Text('Sports'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const ERoundedImage(width: double.infinity, imageUrl: EImages.promoBanner3,applyImageRadius: true),
              const SizedBox(height: ESizes.spaceBtwSections),

              /// Sub-categories
              Column(
                children: [
                  ///Heading
                  ESectionHeading(title: 'Shorts Shirts', onPressed: () {}),
                  const SizedBox(height: ESizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context,index) => const SizedBox(width: ESizes.spaceBtwItems),
                        itemBuilder: (context,index) => const EProductCardHorizontal()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}