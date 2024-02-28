
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
// import 'package:ethnic_elegance/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class EBillingPaymentSection extends StatelessWidget {
  const EBillingPaymentSection({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ESectionHeading(title: 'Payment Method',buttonTitle: 'Change', onPressed: (){}),
        const SizedBox(height: ESizes.spaceBtwItems / 2),
        Row(
          children: [
            ERoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? EColors.light : EColors.white,
              padding: const EdgeInsets.all(ESizes.sm),
              child: const Image(image: AssetImage(EImages.paypal),fit: BoxFit.contain),
            ),
            const SizedBox(width: ESizes.spaceBtwItems / 2),
            Text('Pappal',style: Theme.of(context).textTheme.bodyLarge),
          ],
        )
      ],
    );
  }

}