import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order_history/rent_order_list.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';

class RentOrderHistory extends StatelessWidget{
  const RentOrderHistory({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('My Rent Orders',style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(ESizes.defaultSpace),
        child: ERentOrderListItems(),
      ),
    );
  }

}