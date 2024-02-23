import 'package:ethnic_elegance/features/authentication/screens/signup/verify_email.dart';
import 'package:ethnic_elegance/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class ESignupForm extends StatelessWidget {
  const ESignupForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Form(child: Column(
      children: [
        Row(
          children: [
            //first and last name
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(labelText: "First Name", prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(width: ESizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
              ),
            ),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //username
        TextFormField(
          decoration: const InputDecoration(labelText: "User Name", prefixIcon: Icon(Iconsax.user_edit)),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //email
        TextFormField(
          decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //contact no
        TextFormField(
          decoration: const InputDecoration(labelText: "Contact No", prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //password
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon: Icon(Iconsax.eye_slash),
          ),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        const ETermsandConditionsCheckbox(),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //signup button
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const VerifyEmailScreen()), child: const Text("Create Account"), ),)
      ],
    ));
  }
}

