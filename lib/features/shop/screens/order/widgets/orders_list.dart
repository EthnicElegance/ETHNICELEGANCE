

import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';

class EOrderListItems extends StatelessWidget{
  const EOrderListItems({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: ESizes.spaceBtwItems),
      itemBuilder:(_,index) => ERoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(ESizes.md),
        backgroundColor: dark? EColors.dark : EColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Iconsax.ship),
                const SizedBox(width: ESizes.spaceBtwItems / 2),

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: EColors.primary, fontWeightDelta: 1),
                      ),
                      Text('07 Nov 2024',style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Iconsax.arrow_right_34,size: ESizes.iconSm))
              ],
            ),
            const SizedBox(height: ESizes.spaceBtwItems),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.tag),
                      const SizedBox(width: ESizes.spaceBtwItems / 2),

                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: Theme.of(context).textTheme.labelMedium),
                            Text('#256f2',style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Iconsax.calendar),
                      const SizedBox(width: ESizes.spaceBtwItems / 2),

                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('03 Feb 2024',style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

}