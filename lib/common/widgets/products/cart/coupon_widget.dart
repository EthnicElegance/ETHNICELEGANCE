import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

 class ECouponCode extends StatelessWidget{


   const ECouponCode({super.key});
  @override
  Widget build(BuildContext context) {
    return ERoundedContainer(
      showBorder: true,
      backgroundColor: EHelperFunctions.isDarkMode(context) ? EColors.dark : EColors.white,
      padding: const EdgeInsets.only(top: ESizes.sm,bottom: ESizes.sm,right: ESizes.sm,left: ESizes.md),
      child: Row(
        children: [
          Flexible(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Have a promo code? Enter here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
          ),
        ],
      )
    );
  }

 }