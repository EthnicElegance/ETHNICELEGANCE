
import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () => Get.to(() => const AddNewAddressScreen()),
              backgroundColor: EColors.primary,
              child: const Icon(Iconsax.add,color: EColors.white),
          ),
        appBar: EAppBar(
          showBackArrow: true,
          title: Text('Addresses',style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: const SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                    ESingleAddress(selectedAddress: false),
                    ESingleAddress(selectedAddress: true),
                ],
              )
          ),
        ),
      );
  }

}