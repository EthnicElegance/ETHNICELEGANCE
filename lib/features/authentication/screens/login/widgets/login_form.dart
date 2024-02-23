import 'package:ethnic_elegance/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:ethnic_elegance/features/authentication/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/sizes.dart';

class ELoginForm extends StatelessWidget {
  const ELoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: ESizes.spaceBtwSections),
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: "E-Mail",
            ),
          ),
          const SizedBox(height: ESizes.spaceBtwInputFields),

          //password
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: "Password",
              suffixIcon: Icon(Iconsax.eye_slash),
            ) ,
          ),

          const SizedBox(height: ESizes.spaceBtwInputFields / 2),

          //Remember Me & Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Remember Me
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value){}),
                  const Text("Remember Me"),
                ],
              ),

              //Forget Password
              TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: const Text("Forget Password")),
            ],
          ),

          const SizedBox(height: ESizes.spaceBtwSections),

          //sign In button

          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const NavigationMenu()) , child: const Text("Sign In"))),
          const SizedBox(height: ESizes.spaceBtwItems,),

          //create account button
          SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text("Create Account"))),
          const SizedBox(height: ESizes.spaceBtwSections,)
        ],
      ),
    ),
    );
  }
}
