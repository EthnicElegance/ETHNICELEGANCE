import 'package:ethnic_elegance/common/widgets/layouts/grid_layout.dart';
import 'package:ethnic_elegance/common/widgets/products_cart/product_card_vertical.dart';
// import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';

// import '../../../../../common/widgets/brands/brand_show_case.dart';
// import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class ECategoryTab extends StatelessWidget{
  const ECategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children:[
        Padding(
          padding:const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              //const EBrandShoeCase(images: [EImages.sportIcon,EImages.clothIcon,EImages.shoeIcon]),
              // const EBrandShoeCase(images: [EImages.sportIcon,EImages.clothIcon,EImages.shoeIcon]),
              // const SizedBox(height: ESizes.spaceBtwItems),

              ///Products
              // ESectionHeading(title: 'You might like ' , onPressed: () {}),
              // const SizedBox(height: ESizes.spaceBtwItems),

              EGridLayout(itemCount: 4, itemBuilder: (_, index) => const EProductCardVertical()),
              const SizedBox(height: ESizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}