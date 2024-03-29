import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/navigation_menu.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../models/category/categorylist_model.dart';
import '../brand/all_brands.dart';
import '../search/search.dart';


class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: EAppBar(
          title:
              Text('Category', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            ECartCounterIcon(iconColor: EHelperFunctions.isDarkMode(context) ? EColors.white : EColors.black),
          ],
        ),
        bottomNavigationBar: const NavigationMenu(),
        body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: EHelperFunctions.isDarkMode(context)
                      ? EColors.black
                      : EColors.white,
                  expandedHeight: 800,

                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(ESizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// Search Bar
                        const SizedBox(height: ESizes.spaceBtwItems),
                        ESearchContainer(
                            text: 'Search in store',
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          onTap: () => Get.to(() => const SearchScreen()),
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems),

                        /// Featured Brands
                        ESectionHeading(
                          title: 'Featured Categories',
                          onPressed: () => Get.to(() => const AllBrandsScreen()),
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems / 1.5),

                        ///Brand Grid
                        const ECategoryList(limitedCategory: true,categoryCount: 8,),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Container(),
        ),
      ),
    );
  }

}


