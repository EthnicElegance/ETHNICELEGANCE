import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/icons/circular_icon.dart';
import 'package:ethnic_elegance/common/widgets/layouts/grid_layout.dart';
import 'package:ethnic_elegance/common/widgets/products_cart/product_card_vertical.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(
        title: Text("Wishlist", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ECircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [EGridLayout(itemCount: 4, itemBuilder: (_, index) => const EProductCardVertical() )],
          ),
        ),
      ),
    );
  }
}
