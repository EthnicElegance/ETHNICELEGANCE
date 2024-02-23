import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              //Image
              Image(image: const AssetImage(EImages.deliveredEmailIllustration), width: EHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: ESizes.spaceBtwSections,),

              //title and subtitle
              Text(ETexts.congrats, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              Text(ETexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: ESizes.spaceBtwItems,),
              Text(ETexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: ESizes.spaceBtwItems,),

              //buttons
              SizedBox(width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: const Text("Done"))),
              const SizedBox(height: ESizes.spaceBtwItems,),
              SizedBox(width: double.infinity,
                  child: TextButton(onPressed: () {}, child: const Text("Resend Email"))),
              const SizedBox(height: ESizes.spaceBtwItems,),
            ],
          ),
        ),
      ),
    );
  }
}
