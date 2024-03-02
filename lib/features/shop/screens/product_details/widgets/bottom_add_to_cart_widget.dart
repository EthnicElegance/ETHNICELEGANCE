import 'package:ethnic_elegance/common/widgets/icons/circular_icon.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/popups/loaders.dart';

class CartController extends GetxController {
  final RxString counter = RxString('0');

  void increment() {
    counter.value = (int.parse(counter.value) + 1).toString();
  }

  void decrement() {
    counter.value = (int.parse(counter.value) - 1).toString();
  }
}

class EBottomAddToCart extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  EBottomAddToCart({super.key}); // GetX dependency injection

  @override
  Widget build(BuildContext context) {
    // var count = 0;

    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ESizes.defaultSpace, vertical: ESizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? EColors.darkerGrey : EColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(ESizes.cardRadiusLg),
          topRight: Radius.circular(ESizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ECircularIcon(
                icon: Iconsax.minus,
                backgroundColor: EColors.darkerGrey,
                width: 40,
                height: 40,
                color: EColors.white,
                onPressed: () {
                  if (controller.counter.value != '0') {
                    controller.decrement();
                  }
                },
              ),
              const SizedBox(width: ESizes.spaceBtwItems),
              Obx(
                () => Text(controller.counter.value,
                    style: Theme.of(context).textTheme.titleSmall),
              ),
              const SizedBox(width: ESizes.spaceBtwItems),
              ECircularIcon(
                icon: Iconsax.add,
                backgroundColor: EColors.black,
                width: 40,
                height: 40,
                color: EColors.white,
                onPressed: controller.increment,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.counter.value != '0') {



                // Get.to(() => const CartScreen());
              }else{
                ELoaders.errorSnackBar(
                title: 'Oh snap!', message: "Select Qty");
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(ESizes.md),
              backgroundColor: EColors.black,
              side: const BorderSide(color: EColors.black),
            ),
            child: const Text('Add To Cart'),
          )
        ],
      ),
    );
  }
}
