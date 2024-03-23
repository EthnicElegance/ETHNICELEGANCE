import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/features/shop/screens/coupons/coupon_list.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';


class CouponScreen extends StatelessWidget{
  const CouponScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('My Coupons',style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(ESizes.defaultSpace),
        child: ECouponList(showIcon: false,),
      ),
    );
  }

}