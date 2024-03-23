import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/models/address_view_model.dart';
import '../../../controllers/rent_checkout_controller.dart';

class EBillingAddressSection1 extends StatefulWidget {
  const EBillingAddressSection1({super.key});

  @override
  State<EBillingAddressSection1> createState() => _EBillingAddressSection1State();
}

class _EBillingAddressSection1State extends State<EBillingAddressSection1> {
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
    final controller = Get.put(RentCheckoutController());

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
        });
  }
}
