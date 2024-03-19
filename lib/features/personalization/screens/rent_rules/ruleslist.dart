import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class ERulesList extends StatefulWidget {
  const ERulesList({super.key});

  @override
  State<ERulesList> createState() => _ERulesListState();
}

class _ERulesListState extends State<ERulesList> {
  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
          return ListView.separated(
            shrinkWrap: true,
            itemCount: 1,
            separatorBuilder: (_, __) =>
            const SizedBox(height: ESizes.spaceBtwItems),
            itemBuilder: (_, index) {
          return Column(
            children: [
              ERoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(ESizes.md),
                  backgroundColor: dark ? EColors.dark : EColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: ESizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '1 . Security deposit to be paid at the time of pick up and will be returned after a thorough quality check & on receiving necessary clearances.',
                                    style: Theme.of(context).textTheme.bodyMedium,),
                                const SizedBox(height: ESizes.spaceBtwItems),

                                Text('2 . If outfit is damaged or has stains security amount will be deducted.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium),
                                const SizedBox(height: ESizes.spaceBtwItems),

                                Text('3 . In case of permanent damage, Security deposit will be forfeited and user is expected to pay 30% of the outfit MRP (Minus Security Deposit). ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium),
                                const SizedBox(height: ESizes.spaceBtwItems),

                                Text('4 . If the Product is not returned within the expected day from the Return Date, we will charge you a Late Fee equivalent to an amount of for ex., Rs. 500 per outfit per day and Rs. 200 per accessory per day.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium),
                                const SizedBox(height: ESizes.spaceBtwItems),

                                Text('5 . Cash deposit will be refunded at the time of returning the outfit after QC.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium),
                                const SizedBox(height: ESizes.spaceBtwItems),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  )),


            ],
          );
      },
          );
        }
      }
