import 'package:ethnic_elegance/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //headings
            Text(ETexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ESizes.spaceBtwItems,),
            Text(ETexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: ESizes.spaceBtwSections * 2),

            //text fields
            TextFormField(
              decoration: const InputDecoration(labelText: "Email" , prefixIcon: Icon(Iconsax.direct_right)),
            ),
            const SizedBox(height: ESizes.spaceBtwSections),

            //buttons
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const ResetPassword()), child: const Text("Submit"),),)

          ],
        ),
      ),
    );
  }
}
