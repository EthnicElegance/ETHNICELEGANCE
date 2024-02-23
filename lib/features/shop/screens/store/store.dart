import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ethnic_elegance/common/widgets/images/circular_image.dart';
import 'package:ethnic_elegance/common/widgets/layouts/grid_layout.dart';
import 'package:ethnic_elegance/common/widgets/products_cart/cart_menu_icon.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/shop/screens/store/widgets/category_tab.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/enums.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/tabbar.dart';

import '../../../../common/widgets/icons/brand_title_text_with_verified_iconn.dart';


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
            ECartCounterIcon(onPressed: () {}, iconColor: Colors.black),
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: EHelperFunctions.isDarkMode(context)
                      ? EColors.black
                      : EColors.white,
                  expandedHeight: 440,
      
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
                          title: 'Featured Brands',
                          onPressed: () {},
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems / 1.5),
      
                        ///Brand Grid
                        EGridLayout(
                          itemCount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: ERoundedContainer(
                                padding: const EdgeInsets.all(ESizes.sm),
                                showBorder: true,
                                backgroundColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    ///Icon
                                    Flexible(
                                      child: ECircularImage(
                                        isNetworkImage: false,
                                        image: EImages.sportIcon,
                                        backgroundColor: Colors.transparent,
                                        overlayColor:
                                            EHelperFunctions.isDarkMode(context)
                                                ? EColors.white
                                                : EColors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                        width: ESizes.spaceBtwItems / 2),
      
                                    /// Text
      
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const EBrandTitleWithVerifiedIcon(
                                              title: 'Nike',
                                              brandTextSize: TextSizes.large),
                                          Text(
                                            '256 Products',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
            body: TabBarView(
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


