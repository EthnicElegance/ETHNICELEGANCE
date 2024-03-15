
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class EBillingAddressSection extends StatelessWidget{
  const EBillingAddressSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ESectionHeading(title: 'Address Details',buttonTitle: 'Change', onPressed: (){}),
        Text('Ethnic Elegance',style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: ESizes.spaceBtwItems/2),

        Row(
          children: [
            const Icon(Icons.phone,color: Colors.grey,size: 16),
            const SizedBox(width: ESizes.spaceBtwItems),
            Text('9898567866',style: Theme.of(context).textTheme.bodyMedium),

          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems/2),

        Row(
          children: [
            const Icon(Icons.location_history,color: Colors.grey,size: 16),
            const SizedBox(width: ESizes.spaceBtwItems),
            Expanded(child: Text('city light road,395007,surat ',style: Theme.of(context).textTheme.bodyMedium,softWrap: true)),

          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems/2),
      ],
    );
  }

}