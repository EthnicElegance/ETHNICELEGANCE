import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';

import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';


import 'package:flutter/material.dart';

import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';

import '../../../../utils/constants/sizes.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

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
              itemBuilder: (_, index) => Column(
                children: [
                  const ECartItem(),
                  const SizedBox(height: ESizes.spaceBtwItems),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 70),
                          //add remove button
                          EProductQuantityWithAddRemoveButton(),
                        ],
                      ),
                      const EProductPriceText(price: '256'),
                    ],
                  )
                ],
              ),
          ),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: ElevatedButton(onPressed: () {}/*Get.to(() => const CheckOutScreen()*/, child: const Text("Checkout \$256.0"),),
      ),
    );
  }
}



