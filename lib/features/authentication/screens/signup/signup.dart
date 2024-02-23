import 'package:ethnic_elegance/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';


import '../../../../utils/constants/sizes.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Let's Create Your Account",style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: ESizes.spaceBtwSections),

                const ESignupForm()
              ],
            ),
          ),
      ),
    );
  }
}


