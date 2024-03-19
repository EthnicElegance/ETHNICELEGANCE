import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../models/address_view_model.dart';

class ESingleAddress extends StatefulWidget {
  const ESingleAddress(
      {super.key,
        required this.selectedAddress,
        required this.addressId,
        required this.addressIndex});

  final bool selectedAddress;
  final String addressId;
  final int addressIndex;

  @override
  State<ESingleAddress> createState() => _ESingleAddressState();
}

class _ESingleAddressState extends State<ESingleAddress> {
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
    final dark = EHelperFunctions.isDarkMode(context);

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
            print(addressList[0].addressId);
            return ERoundedContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(ESizes.md),
                showBorder: true,
                backgroundColor: widget.selectedAddress
                    ? EColors.primary.withOpacity(0.5)
                    : Colors.transparent,
                borderColor: widget.selectedAddress
                    ? Colors.transparent
                    : dark
                        ? EColors.darkerGrey
                        : EColors.grey,
                margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
                child: Stack(
                  children: [
                    Positioned(
                      right: 5,
                      top: 0,
                      child: Icon(
                        widget.selectedAddress ? Iconsax.tick_circle5 : null,
                        color: widget.selectedAddress
                            ? dark
                                ? EColors.light
                                : EColors.dark
                            : null,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addressList[widget.addressIndex].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: ESizes.sm / 2),
                        Text(addressList[widget.addressIndex].contact,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: ESizes.sm / 2),
                        Text(addressList[widget.addressIndex].address, softWrap: true),
                        IconButton(
                          onPressed: () {
                            // Delete item from the cart in Firebase
                            FirebaseDatabase.instance
                                .ref()
                                .child("Project/Address/${addressList[widget.addressIndex].addressId}")
                                .remove()
                                .then((_) {})
                                .catchError((error) => ELoaders.errorSnackBar(
                                title: 'Failed to remove',
                                message: 'Failed to remove item: $error'));
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        ),
                        const SizedBox(width: ESizes.spaceBtwItems),
                      ],
                    )
                  ],
                ));
          }
        });
  }
}
