import 'package:ethnic_elegance/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ethnic_elegance/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class ESignupForm extends StatefulWidget {
  const ESignupForm({super.key});

  @override
  State<ESignupForm> createState() => ESignupFormState();
}


class ESignupFormState extends State<ESignupForm> {
  late int selectedRadio;

  @override
  void initState(){
    super.initState();
    selectedRadio = 2;
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
        child: Column(
          children: [
            //first and last name
            Row(
              children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstname,
                  validator: (value) => EValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: "First Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: ESizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastname,
                  validator: (value) => EValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: ESizes.spaceBtwInputFields),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(child: Text("User Type", style: Theme.of(context).textTheme.titleMedium)),
              RadioListTile(
                value: 1,
                groupValue: selectedRadio,
                title: const Text("Business Customer"),
                onChanged: (val){
                  // print("you selected $val");
                  setSelectedRadio(val!);
                },
                activeColor: EColors.primary,

              ),

              RadioListTile(
                value: 2,
                groupValue: selectedRadio,
                title: const Text("Retail Customer"),
                onChanged: (val){
                  // print("you selected $val");
                  setSelectedRadio(val!);
                },
                activeColor: EColors.primary,
              ),

            ],

          ),



        //email
        TextFormField(
          controller: controller.email,
          validator: (value) => EValidator.validateEmail(value),
          decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //contact no
        TextFormField(
          controller: controller.contactNumber,
          validator: (value) => EValidator.validatePhoneNumber(value),
          decoration: const InputDecoration(labelText: "Contact No", prefixIcon: Icon(Iconsax.call)),
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
                onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                icon:Icon(controller.hidePassword.value? Iconsax.eye_slash : Iconsax.eye),
              ),
            ),
          ),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //confirm Password
        Obx(
          () => TextFormField(
            validator: (value) => EValidator.validateConfirmPassword(value,controller.password.text),
            controller: controller.cpassword,
            obscureText: controller.hidePassword1.value,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
              onPressed: () => controller.hidePassword1.value = !controller.hidePassword1.value,
              icon: Icon(controller.hidePassword1.value? Iconsax.eye_slash : Iconsax.eye),
              ),
          ),
        ),
        ),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        const ETermsandConditionsCheckbox(),
        const SizedBox(height: ESizes.spaceBtwInputFields),

        //signup button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.signup(selectedRadio),
            child: const Text("Create Account"), ),)
      ],
    ));
  }

}

