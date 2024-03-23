import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/features/shop/controllers/coupon_controller.dart';
import 'package:ethnic_elegance/features/shop/screens/coupons/coupon_list.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../appbar/appbar.dart';
class ECouponCode extends StatefulWidget {
  const ECouponCode({super.key});

  @override
  State<ECouponCode> createState() => _ECouponCodeState();
}

class _ECouponCodeState extends State<ECouponCode> {
  final controller = Get.put(CouponController());

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
                enabled: false,
                controller: controller.couponName,
                decoration: const InputDecoration(
                  hintText: 'Have a coupon code? Enter here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
          ),
          
          ///Apply button
          
          ElevatedButton(onPressed: () => Get.to(() => Scaffold(
            appBar: EAppBar(title: Text('My Coupons',style: Theme.of(context).textTheme.headlineSmall)),
            body: const Padding(
              padding: EdgeInsets.all(ESizes.defaultSpace),
              child: ECouponList(showIcon: true,),
            ),
          )), style: ElevatedButton.styleFrom(
            foregroundColor: EHelperFunctions.isDarkMode(context) ? EColors.white.withOpacity(0.5) : EColors.dark.withOpacity(0.5),
            backgroundColor: EColors.grey.withOpacity(0.2),
            side: BorderSide(color: EColors.grey.withOpacity(0.0))
          ),
          child:  const Text("Apply", style: TextStyle(color: Colors.black)), )
        ],
      )
    );
  }

 }