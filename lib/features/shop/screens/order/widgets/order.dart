
import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import 'orders_list.dart';

class OrderScreen extends StatelessWidget{
  const OrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: EAppBar(title: Text('My Orders',style: Theme.of(context).textTheme.headlineSmall)),
        body: const Padding(
            padding: EdgeInsets.all(ESizes.defaultSpace),
          child: EOrderListItems(),
        ),
      );
  }

}