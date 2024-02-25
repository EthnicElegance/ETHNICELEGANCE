import 'package:ethnic_elegance/features/authentication/controllers/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ETermsandConditionsCheckbox extends StatelessWidget {
  const ETermsandConditionsCheckbox({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = EHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 24, height: 24, child: Obx(() => Checkbox(value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
        const SizedBox(width: ESizes.spaceBtwItems),
        Text.rich(TextSpan(
            children: [
              TextSpan(text: "I Agree To " , style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: "Privacy Policy " , style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? EColors.white : EColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? EColors.white : EColors.primary,
              )),
              TextSpan(text: "and " , style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: "Terms Of Use " , style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? EColors.white : EColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark ? EColors.white : EColors.primary,
              )),
            ]
        ))
      ],
    );
  }
}