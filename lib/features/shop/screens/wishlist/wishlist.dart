import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/icons/circular_icon.dart';
import 'package:ethnic_elegance/features/shop/screens/all_product/all_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../models/productlist_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(
        title:
            Text("Wishlist", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ECircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const AllProducts())),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              EProductList(limitedProduct: true,productCount: 8),

              // EGridLayout(
              //     itemCount: 4,
              //     itemBuilder: (_, index) => const EProductCardVertical())
            ],
          ),
        ),
      ),
    );
  }
}
