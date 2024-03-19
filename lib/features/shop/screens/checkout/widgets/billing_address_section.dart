import 'package:ethnic_elegance/features/personalization/screens/address/widgets/add_new_address.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/models/address_view_model.dart';
import '../../../controllers/checkout_controller.dart';

class EBillingAddressSection extends StatefulWidget {
  const EBillingAddressSection({super.key});

  @override
  State<EBillingAddressSection> createState() => _EBillingAddressSectionState();
}

class _EBillingAddressSectionState extends State<EBillingAddressSection> {
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
    final controller = Get.put(CheckoutController());

    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref()
            .child('Project/Address')
            .orderByChild('UserId')
            .equalTo(userId)
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
            return const Center(
              child: Text(
                'Address is Empty',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            Map<dynamic, dynamic> addressData =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<AddressViewModel> addressList = [];

            addressData.forEach((key, value) {
              if (value != null) {
                addressList.add(AddressViewModel(
                  key.toString(),
                  value["UserId"],
                  value["Name"],
                  value["Contact"],
                  value["Address"],
                  value["Pincode"],
                  value["City"],
                  value["State"],
                ));
              }
            });

            controller.userAddress = "${addressList[0].address},${addressList[0].city},${addressList[0].state},${addressList[0].pincode}";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ESectionHeading(
                    title: 'Shipping Address',
                    buttonTitle: 'Change',
                    // showActionButton: false,
                    onPressed: () => Get.to(() => const AddNewAddressScreen())
                ),
                const SizedBox(height: ESizes.spaceBtwItems / 2),

                Text(addressList[0].name,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: ESizes.spaceBtwItems / 2),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.grey, size: 16),
                    const SizedBox(width: ESizes.spaceBtwItems),
                    Text(addressList[0].contact,
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
                        child: Text(addressList[0].address,
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
