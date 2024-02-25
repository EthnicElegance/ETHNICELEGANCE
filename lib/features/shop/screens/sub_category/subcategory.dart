import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../models/categorylist_model.dart';
import '../brand/all_brands.dart';
import '../store/widgets/category_tab.dart';


class subCategoryScreen extends StatelessWidget {
  const subCategoryScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    // Query res = FirebaseDatabase.instance.ref().child('Project/subcategory').orderByChild("catid").equalTo(id);

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: EAppBar(
          title:
          Text('Sub Category', style: Theme.of(context).textTheme.headlineMedium),
          actions: const [
            ECartCounterIcon(iconColor: Colors.black),
          ],
        ),
        body: NestedScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: EHelperFunctions.isDarkMode(context)
                    ? EColors.black
                    : EColors.white,
                expandedHeight: 50,

                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(ESizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Search Bar
                      const SizedBox(height: ESizes.spaceBtwItems),
                      const ESearchContainer(
                        text: 'Search in store',
                        showBorer: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems),

                      /// Featured Brands
                      ESectionHeading(
                        title: 'Featured Categories',
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems / 1.5),

                      ///Brand Grid
                      const ECategoryList(limitedCategory: true,categoryCount: 6,),
                    ],
                  ),
                ),

                ///Tabs
                bottom: const ETabBar(
                    tabs: [
                      Tab(child: Text('Kurti')),
                      Tab(child: Text('Lengha-Choli')),
                      Tab(child: Text('Dupatta')),
                      Tab(child: Text('Saree')),
                      Tab(child: Text('Salwar-Suit')),
                      Tab(child: Text('Blouse')),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              ECategoryTab(),
              ECategoryTab(),
              ECategoryTab(),
              ECategoryTab(),
              ECategoryTab(),
              ECategoryTab(),
            ],
          ),
        ),
      ),
    );
  }

}


