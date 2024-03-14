import 'package:ethnic_elegance/features/shop/models/subcat_productlist_model.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products_cart/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class ECategoryTab extends StatelessWidget{
  const ECategoryTab({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding:const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              //Brands
              // const EBrandShoeCase(images: [EImages.sportIcon,EImages.clothIcon,EImages.shoeIcon]),
              // const EBrandShoeCase(images: [EImages.sportIcon,EImages.clothIcon,EImages.shoeIcon]),
              // const SizedBox(height: ESizes.spaceBtwItems),

              //Products
              //ESectionHeading(title: 'You might like ' , onPressed: () {}),
              const SizedBox(height: ESizes.spaceBtwItems),
              ESubCatProductList(productSubCat: data,),

              //EGridLayout(itemCount: 4, itemBuilder: (_, index) => const EProductCardVertical()),
              const SizedBox(height: ESizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}