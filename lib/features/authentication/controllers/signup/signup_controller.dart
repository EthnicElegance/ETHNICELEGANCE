import 'dart:convert';
// import 'dart:js';

import 'package:crypto/crypto.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/popups/full_screen_loader.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';
// import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

// import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';

// import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../models/signup_model.dart';
// import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final hidePassword1 = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final contactNumber = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();
  String usertype = '' ;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('Project/UserRegister');

  //Signup
  void signup(selectedRadio) async {
    try {
      //Start loading
      EFullScreenLoader.openLoadingDialog(
          'We are processing your information', EImages.acerlogo);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();


      if (!isConnected) {
        //remove loader
        EFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!signupFormKey.currentState!.validate()) {
        //remove loader
        EFullScreenLoader.stopLoading();
        return;
      }

      //privacy policy
      if (!privacyPolicy.value) {
        ELoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account , you must have to accept the privacy policy and terms of use');
        EFullScreenLoader.stopLoading();
        return;
      }

      // //register user in the firebase authentication & save user data in the firebase
      // final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());
      //
      // //save authenticated userdata in the Firebase Firestore
      // final newUser = UserModel(
      //   id: userCredential.user!.uid,
      //   firstname: firstname.text.trim(),
      //   lastname: lastname.text.trim(),
      //   email: email.text.trim(),
      //   // contactNumber: contactNumber.text.trim(),
      //   profilePicture: '',
      //   phoneNumber: contactNumber.text.trim(),
      // );
      // final userRepository = Get.put(UserRepository());
      // await userRepository.saveUserRecord(newUser);
      //
      // //remove loader
      //
      // //show success message
      //
      //move to verify email screen

      if(selectedRadio == 2){
        usertype = 'Retail Customer';
      }else{
        usertype = 'Business Customer';
      }

        String pass1 = encryptString(password.text.trim());
        SignupModel regobj = SignupModel(
            firstname.text.trim(),
            lastname.text.trim(),
            usertype,
            contactNumber.text.trim(),
            email.text.trim(),
            pass1);
        dbRef.push().set(regobj.toJson());

      EFullScreenLoader.stopLoading();

      ELoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue');
      // Get.to(() => const NavigationMenu());
      Get.to(
            () =>
            SuccessScreen(
                image: EImages.successfullyRegisterAnimation,
                title: ETexts.yourAccountCreatedTitle,
                subTitle: ETexts.yourAccountCreatedSubTitle,
                onPressed: () => Get.to(() => const HomeScreen())
            ),
      );
      // Navigator.of(context).pop();
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => SuccessScreen(
      //                   image: EImages.successfullyRegisterAnimation,
      //                   title: ETexts.yourAccountCreatedTitle,
      //                   subTitle: ETexts.yourAccountCreatedSubTitle,
      //                   onPressed: () => Get.offAll(() => const NavigationMenu())
      //               ),
      //     )
      // );
    } catch (e) {
      /*//remove loader
      EFullScreenLoader.stopLoading();*/
      //show error to user
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
    // finally {
    //   //remove loader
    //   EFullScreenLoader.stopLoading();
    // }
  }

  String encryptString(String originalString) {
    var bytes = utf8.encode(originalString); // Convert string to bytes
    var digest = sha256.convert(bytes); // Apply SHA-256 hash function
    return digest.toString(); // Return the hashed string
  }
}
