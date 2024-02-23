import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';

import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';


import 'package:flutter/material.dart';

import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';

import '../../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(showBackArrow:true ,title: Text("cart", style: Theme.of(context).textTheme.headlineMedium,)),
      body: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: 8,
              separatorBuilder: (_, __) => const SizedBox(height: ESizes.spaceBtwSections,),
              itemBuilder: (_, index) => const Column(
                children: [
                  ECartItem(),
                  SizedBox(height: ESizes.spaceBtwItems),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 70),
                          //add remove button
                          EProductQuantityWithAddRemoveButton(),
                        ],
                      ),
                      EProductPriceText(price: '256'),
                    ],
                  )
                ],
              ),
          ),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: ElevatedButton(onPressed: (){}, child: const Text("Checkout \$256.0"),),
      ),
    );
  }
}



