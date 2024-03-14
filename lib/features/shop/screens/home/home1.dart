import 'package:ethnic_elegance/features/shop/screens/all_product/all_products.dart';
import 'package:ethnic_elegance/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ethnic_elegance/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ethnic_elegance/features/shop/screens/home/widgets/promo_slider.dart';

import 'package:ethnic_elegance/navigation_menu1.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../sharepreferences.dart';
import '../../models/productlist_model1.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();

}



class _HomeScreen1State extends State<HomeScreen1> {
  String? userid;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavigationMenu1(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            const EPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  EHomeAppBar(),

                  SizedBox(
                    height: ESizes.spaceBtwSections,
                  ),

                  /// Searchbar
                  ESearchContainer(text: 'Search in Store'),
                  SizedBox(
                    height: ESizes.spaceBtwSections,
                  ),

                  /// Categories
                  Padding(
                    padding: EdgeInsets.only(left: ESizes.defaultSpace),
                    child: Column(
                      children: [
                        /// header
                        ESectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: EColors.white,
                        ),
                        SizedBox(
                          height: ESizes.spaceBtwItems,
                        ),

                        ///categories
                        EHomeCategories(),
                      ],
                    ),
                  ),

              SizedBox(height: ESizes.spaceBtwSections,),

                ],
              ),
            ),

            ///Body
            ///Banner
            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  ///Product Slider
                  FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      return const EPromoSlider(
                        banners: [
                          EImages.onBoardingImage1,
                          EImages.onBoardingImage2,
                          EImages.onBoardingImage3,
                        ],
                      );
                    }
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections),

                  ///Heading
                  ESectionHeading(title: 'Popular Product', onPressed: () =>Get.to(() => const AllProducts())),
                  const SizedBox(height: ESizes.spaceBtwSections),

                  ///Popular Products
                  const EProductList1(limitedProduct: true,productCount: 6),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}