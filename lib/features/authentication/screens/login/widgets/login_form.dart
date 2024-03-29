import 'package:ethnic_elegance/features/authentication/controllers/signin/signin_controller.dart';
import 'package:ethnic_elegance/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:ethnic_elegance/features/authentication/screens/signup/signup.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';

class ELoginForm extends StatefulWidget {
  const ELoginForm({super.key});

  @override
  State<ELoginForm> createState() => _ELoginFormState();
}

class _ELoginFormState extends State<ELoginForm> {
  late bool containsKey;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    containsKey = prefs.containsKey('key');

    if (containsKey) {
      // If the key exists, navigate to HomePage
      Get.offAll(() => const HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SigninController());
    return Form(
      key: controller.signinFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ESizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => EValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: "E-Mail",
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwInputFields),

            //password
            Obx(
              () => TextFormField(
                validator: (value) => EValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),

            const SizedBox(height: ESizes.spaceBtwInputFields / 2),

            //Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Remember Me
                const Row(
                  children: [
                    // Checkbox(value: true, onChanged: (value){}),
                    Text(""),
                  ],
                ),

                //Forget Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text("Forget Password")),
              ],
            ),

            const SizedBox(height: ESizes.spaceBtwSections),

            //sign In button

            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.signin(context),
                    child: const Text("Sign In"))),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),

            //create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text("Create Account"))),
            const SizedBox(
              height: ESizes.spaceBtwSections,
            )
          ],
        ),
      ),
    );
  }
}
