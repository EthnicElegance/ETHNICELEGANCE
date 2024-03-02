import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/circular_icon.dart';
class CartController extends GetxController {
  final RxString counter = RxString('0');

  void increment() {
    counter.value = (int.parse(counter.value) + 1).toString();
  }

  void decrement() {
    counter.value = (int.parse(counter.value) - 1).toString();
  }
}

class EProductQuantityWithAddRemoveButton extends StatelessWidget {
  final CartController controller = Get.put(CartController());
  EProductQuantityWithAddRemoveButton({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    // var count = 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ECircularIcon(
          onPressed: () {
            {
              if (controller.counter.value != '0') {
                controller.decrement();
              }
            }
          },
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: EHelperFunctions.isDarkMode(context) ? EColors.white : EColors.black,
          backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.darkerGrey : EColors.light,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),
        Obx(
              () => Text(controller.counter.value,
              style: Theme.of(context).textTheme.titleSmall),
        ),
        // Text(count.toString(),style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: ESizes.spaceBtwItems),
        ECircularIcon(
          onPressed: controller.increment,
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: EColors.white ,
          backgroundColor: EColors.primary,
        ),
      ],
    );
  }
}