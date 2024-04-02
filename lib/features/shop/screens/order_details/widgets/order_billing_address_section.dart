import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';

class EOrderBillingAddressSection extends StatefulWidget {
  const EOrderBillingAddressSection({super.key, required this.orderId});
  final String orderId;

  @override
  State<EOrderBillingAddressSection> createState() => _EOrderBillingAddressSectionState();
}

class _EOrderBillingAddressSectionState extends State<EOrderBillingAddressSection> {
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

    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('Project/Order/${widget.orderId}')
            .onValue,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                strokeWidth: 1.5,
              ),
            );
          } else if (!snapshot.hasData ||
              snapshot.data!.snapshot.value == null) {
            return const Column(
              children: [
                SizedBox(height: ESizes.spaceBtwItems / 2),
                Center(
                  child: Text(
                    'Address Not Available',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          } else {
            Map<dynamic, dynamic> addressData =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ESectionHeading(
                    title: 'Shipping Address',
                    showActionButton: false,
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.location_history,
                        color: Colors.grey, size: 16),
                    const SizedBox(width: ESizes.spaceBtwItems),
                    Expanded(
                        child: Text(addressData['UserAddress'],
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true)),
                  ],
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
              ],
            );
          }
        });
  }
}
