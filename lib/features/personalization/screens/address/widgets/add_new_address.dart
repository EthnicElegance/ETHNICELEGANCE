import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/features/personalization/controllers/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
        appBar:
            const EAppBar(showBackArrow: true, title: Text('Add new Address')),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(ESizes.defaultSpace),
                child: Form(
                    key: controller.addressKey,
                    child: Column(
                  children: [
                    TextFormField(
                        controller: controller.name,
                        validator: (value) => EValidator.validateEmptyText('Name', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
                    const SizedBox(height: ESizes.spaceBtwInputFields),

                    TextFormField(
                        controller: controller.contact,
                        validator: (value) => EValidator.validateEmptyText('Contact No', value),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.mobile), labelText: 'Contact Number')),
                    const SizedBox(height: ESizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: controller.address,
                              validator: (value) => EValidator.validateEmptyText('Address', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.building_31), labelText: 'Address', hintText: 'House No,Building,street,Area')),
                        ),
                        const SizedBox(width: ESizes.spaceBtwInputFields),

                        Expanded(
                          child: TextFormField(
                              controller: controller.pincode,
                              keyboardType: TextInputType.number,
                              validator: (value) => EValidator.validateEmptyText('Pin Code', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.code), labelText: 'Pin Code')),
                        ),
                      ],
                    ),
                    const SizedBox(height: ESizes.spaceBtwInputFields),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: controller.city,
                              validator: (value) => EValidator.validateEmptyText('City', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.building), labelText: 'City')),
                        ),
                        const SizedBox(width: ESizes.spaceBtwInputFields),

                        Expanded(
                          child: TextFormField(
                              controller: controller.state,
                              validator: (value) => EValidator.validateEmptyText('State', value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.activity), labelText: 'State')),
                        ),
                      ],
                    ),
                    const SizedBox(height: ESizes.defaultSpace),
                    SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => controller.insertAddress(), child: const Text('Save')),)
                  ],
                )))));
  }
}
