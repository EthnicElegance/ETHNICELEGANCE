import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/shop/models/categorylist_model.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllBrandsScreen extends StatelessWidget{
  const AllBrandsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: EAppBar(title: Text('Category'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              ESectionHeading(title: 'Categories', showActionButton: false,),
              SizedBox(height: ESizes.spaceBtwItems),

              /// Brands
              ECategoryList()
              //EGridLayout(itemCount: 10,mainAxisExtent: 80, itemBuilder: (context, index) =>  EBrandCard(showBorder: true,onTap: () => Get.to(() => const BrandProducts()))),

            ],
          ),
        ),
      ),
    );
  }
}