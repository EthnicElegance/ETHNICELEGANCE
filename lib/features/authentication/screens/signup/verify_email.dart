import 'package:ethnic_elegance/common/widgets/success_screen/success_screen.dart';
import 'package:ethnic_elegance/features/authentication/screens/login/login.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/constants/text_strings.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(() => const LoginScreen()), icon: const Icon(CupertinoIcons.clear))
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
              Text(ETexts.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: ESizes.spaceBtwItems,),
              Text(ETexts.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: ESizes.spaceBtwItems,),

              //buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => SuccessScreen(
                image: EImages.staticSuccessIllustration,
                title: ETexts.yourAccountCreatedTitle,
                subTitle: ETexts.yourAccountCreatedSubTitle,
                onPressed: () => Get.to(() => const LoginScreen()),)), child: const Text("Continue"))),
              const SizedBox(height: ESizes.spaceBtwItems,),
              SizedBox(width: double.infinity, child: TextButton(onPressed: () {}, child: const Text("Resend Email"))),
            ],
          ),
        ),
      ),
    );
  }
}
