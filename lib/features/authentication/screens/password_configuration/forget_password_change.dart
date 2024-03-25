import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ethnic_elegance/features/authentication/controllers/forget_password/forgetpassword_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

class ForgetPasswordChange extends StatefulWidget {
  const ForgetPasswordChange({super.key,this.userId});

   final String? userId;

  @override
  State<ForgetPasswordChange> createState() => _ForgetPasswordChangeState();
}

class _ForgetPasswordChangeState extends State<ForgetPasswordChange> {
  final controller = Get.put(ForgetPasswordController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.forgetPasswordChangeFormKey,
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //headings
              Text(ETexts.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
              Text(ETexts.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: ESizes.spaceBtwSections * 2),
        
              //text fields
              Obx(
                () => TextFormField(
                  validator: (value) => EValidator.validatePassword(value),
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: Icon(
                          controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: ESizes.spaceBtwSections),
              Obx(
                () => TextFormField(
                  validator: (value) => EValidator.validateConfirmPassword(value, controller.password.text),
                  controller: controller.cpassword,
                  obscureText: controller.hidePassword1.value,
                  decoration: InputDecoration(
                    labelText: "Conform Password",
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword1.value = !controller.hidePassword1.value,
                      icon: Icon(
                          controller.hidePassword1.value ? Iconsax.eye_slash : Iconsax.eye),
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: ESizes.spaceBtwSections),
        
              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed: () => Get.to(() => const ResetPassword()),
        
                    onPressed: () {
                      controller.forgetPass(context, widget.userId!);
                    },
                  child: const Text("Submit"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  String encryptString(String originalString) {
    var bytes = utf8.encode(originalString); // Convert string to bytes
    var digest = sha256.convert(bytes); // Apply SHA-256 hash function
    return digest.toString(); // Return the hashed string
  }
}
