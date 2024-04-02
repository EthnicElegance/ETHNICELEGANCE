import 'package:flutter/material.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';

class RentOrderDetailEBillingAddressSection extends StatefulWidget {
  const RentOrderDetailEBillingAddressSection({super.key});

  @override
  State<RentOrderDetailEBillingAddressSection> createState() => _RentOrderDetailEBillingAddressSectionState();
}

class _RentOrderDetailEBillingAddressSectionState extends State<RentOrderDetailEBillingAddressSection> {
  String? userId;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ESectionHeading(
                    title: 'Pickup Address',
                    showActionButton: false,
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),

                Text("EthnicElegance",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 16),
                    const SizedBox(width: ESizes.spaceBtwItems),
                    Text("9898787299",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.location_history,
                        color: Colors.grey, size: 16),
                    const SizedBox(width: ESizes.spaceBtwItems),
                    Expanded(
                        child: Text("Factory House No: 8-9 Navrang Industrial Ring Road, Surat",
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true)),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
              ],
            );
  }
}
