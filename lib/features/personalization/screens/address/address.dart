import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/features/personalization/models/address_view_model.dart';
import 'package:ethnic_elegance/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ethnic_elegance/features/personalization/screens/settings/settings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/add_new_address.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({super.key});

  @override
  State<UserAddressScreen> createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {

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
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                backgroundColor: EColors.primary,
                child: const Icon(Iconsax.add, color: EColors.white),
              ),
              appBar: EAppBar(
                showBackArrow: true,
                title: Text(
                  "Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: const Center(
                child: Text(
                  'Address is Empty',
                  style: TextStyle(fontSize: 16),
                ),
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

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                backgroundColor: EColors.primary,
                child: const Icon(Iconsax.add, color: EColors.white),
              ),
              appBar: EAppBar(
                showBackArrow: false,
                leadingIcon: Iconsax.arrow_left,
                leadingOnPressed: () => Get.offAll(() => const SettingsScreen()),
                title: Text('Addresses',
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(ESizes.defaultSpace),
                    child: Column(
                      children: [
                        for(int i = 0; i < addressList.length; i++)
                          ESingleAddress(selectedAddress: false,addressId: addressList[i].addressId,addressIndex: i),
                      ],
                    )),
              ),
            );
          }
        });
  }
}
