import 'package:ethnic_elegance/features/authentication/screens/signup/verify_email.dart';
import 'package:ethnic_elegance/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
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
    selectedRadio = 0;
  }

  setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {

    //selectedRadio = 0;

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

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(child: Text("User Type", style: Theme.of(context).textTheme.titleMedium)),
            RadioListTile(
              value: 1,
              groupValue: selectedRadio,
              title: const Text("Business Customer"),
              onChanged: (val){
                print("you selected $val");
                setSelectedRadio(val!);
              },
              activeColor: EColors.primary,

            ),

            RadioListTile(
              value: 2,
              groupValue: selectedRadio,
              title: const Text("Retail Customer"),
              onChanged: (val){
                print("you selected $val");
                setSelectedRadio(val!);
              },
              activeColor: EColors.primary,
            ),
            
          ],

        ),



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

        //confirm Password
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Confirm Password",
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon: Icon(Iconsax.eye_slash),),
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

