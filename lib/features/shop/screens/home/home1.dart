import 'package:ethnic_elegance/features/shop/screens/all_product/all_products.dart';
import 'package:ethnic_elegance/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ethnic_elegance/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ethnic_elegance/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ethnic_elegance/features/shop/screens/search/search.dart';
import 'package:ethnic_elegance/navigation_menu1.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../sharepreferences.dart';
import '../../models/product/productlist_model1.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();

}

class _HomeScreen1State extends State<HomeScreen1> {
  String? userid;
  List<String> offerImages = [];
  String searchQuery = ''; // Initialize search query


  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
    });
    getOfferImages();
  }

  Future<void> getOfferImages() async {
    final offerRef = FirebaseDatabase.instance.ref().child('Project/Offer');

    await offerRef.once().then((snapshot) {
      final data = snapshot.snapshot.value;
      if (data != null) {
        offerImages.clear();

        if (data is Map) {
          // If data is a map, iterate over its values
          for (var entry in data.values) {
            if (entry is Map && entry.containsKey('photo')) {
              setState(() {
                String imageUrl =
                    "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/OfferImage%2F${entry['photo']}?alt=media";
                offerImages.add(imageUrl);
              });
            }
          }
        }
      }
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
             EPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// AppBar
                  const EHomeAppBar(),

                  const SizedBox(
                    height: ESizes.spaceBtwSections,
                  ),

                  /// Searchbar
                  
                  // ESearchContainer(text: 'Search in Store'/*,onTap: () => Get.to(() => const ESearchScreen()),*/),
                  ESearchContainer(
                    text: 'Search in Store',
                    onTap: () => Get.to(() => const SearchScreen()), // Handle search
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtwSections,
                  ),

                  /// Categories
                  const Padding(
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

              const SizedBox(height: ESizes.spaceBtwSections,),

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
                  if(offerImages.isNotEmpty)
                    EPromoSlider(banners: offerImages),
                  if(offerImages.isEmpty)
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: EColors.grey,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  const SizedBox(height: ESizes.spaceBtwSections),

                  ///Heading
                  ESectionHeading(title: 'Popular Product', onPressed: () =>Get.to(() => const AllProducts())),
                  const SizedBox(height: ESizes.spaceBtwSections),

                  ///Popular Products
                  const EProductList1(limitedProduct: true,productCount: 6, sortBy: 'All Products',),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}