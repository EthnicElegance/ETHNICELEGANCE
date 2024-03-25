import 'package:email_otp/email_otp.dart';
import 'package:ethnic_elegance/features/authentication/controllers/forget_password/forgetpassword_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/validators/validation.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final controller = Get.put(ForgetPasswordController());

  // TextEditingController controllerOTP = TextEditingController();
  bool disable = false;
  EmailOTP myAuth = EmailOTP();
  String? key;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.forgetPasswordFormKey,
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
              TextFormField(
                validator: (value) => EValidator.validateEmail(value),
                controller: controller.email,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Iconsax.direct_right),
                  suffixIcon: TextButton(
                    onPressed: () async {

                      final dbRef =
                      FirebaseDatabase.instance.ref().child('Project/UserRegister').orderByChild("Email").equalTo(controller.email.text);
                      final snapshot = await dbRef.once();

                      // Check if any data was retrieved
                      if (snapshot.snapshot.children.isEmpty) {
                        // Handle empty dbRef case (e.g., display error message)
                        ELoaders.errorSnackBar(title: 'Email not found', message: 'The provided email is not registered.');
                        return;
                      }else {
                        await dbRef.once().then((documentSnapshot) async
                        {
                        for (var x in documentSnapshot.snapshot.children) {
                          controller.userKey = x.key!;
                          myAuth.setConfig(
                            appEmail: "ethnicelegance06@gmail.com",
                            appName: "Ethnic Elegance",
                            userEmail: controller.email.text,
                            otpLength: 6,
                            otpType: OTPType.mixed,
                          );

                          myAuth.setTheme(theme: "v2");
                          if (await myAuth.sendOTP() == true) {
                            ELoaders.successSnackBar(
                                title: 'OTP Sent', message: 'OTP has been sent');
                            setState(() {
                              disable = true;
                            });
                          } else {
                            ELoaders.errorSnackBar(
                                title: 'Oh snap!',
                                message: "OTP send failed, Wrong Email");
                          }
                        }
                        });
                      }
                    },
                    child: const Text("Send OTP"),
                  ),
                ),
              ),
              const SizedBox(height: ESizes.spaceBtwSections),
              TextFormField(
                controller: controller.controllerOTP,
                enabled: disable,
                decoration: const InputDecoration(
                  labelText: "Enter OTP",
                  prefixIcon: Icon(Iconsax.password_check),
                ),
              ),

              const SizedBox(height: ESizes.spaceBtwSections),

              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed: () => Get.to(() => const ResetPassword()),
                  onPressed: () async {
                    controller.forgetPassEmail(context, myAuth);
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
}
