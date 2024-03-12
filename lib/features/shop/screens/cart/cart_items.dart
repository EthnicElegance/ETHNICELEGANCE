import 'package:ethnic_elegance/common/widgets/products/cart/add_remove_button.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class ECartItems extends StatelessWidget{
  const ECartItems({super.key, this.showAddRemoveButtons = true,});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_,__) => const SizedBox(height: ESizes.spaceBtwItems),
      itemBuilder: (_,index) => Column(
        children: [
            const ECartItems(),
          if(showAddRemoveButtons) const SizedBox(height: ESizes.spaceBtwItems),

          if(showAddRemoveButtons)
            const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 70),
                  // EProductQuantityWithAddRemoveButton(cartQty: '', cartId: '', price: '',),

                  EProductPriceText(price: '256'),
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}