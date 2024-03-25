import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/popups/full_screen_loader.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../screens/password_configuration/forget_password_change.dart';
import '../../screens/password_configuration/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final hidePassword1 = true.obs;
  late final String userKey;
  final controllerOTP = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final cpassword = TextEditingController();


  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgetPasswordChangeFormKey = GlobalKey<FormState>();


  //Email otp verification
  void forgetPassEmail(BuildContext context, myAuth) async {
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
      if (!forgetPasswordFormKey.currentState!.validate()) {
        //remove loader
        EFullScreenLoader.stopLoading();
        return;
      }
      EFullScreenLoader.stopLoading();

      if (await myAuth.verifyOTP(otp: controllerOTP.text) == true) {
        Get.to(() => ForgetPasswordChange(userId: userKey));
      } else {
        ELoaders.errorSnackBar(
            title: 'Oh snap!', message: "Wrong OTP");
      }

    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }

  }
  //Password changing process
  void forgetPass(BuildContext context,String userId) async {
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
      if (!forgetPasswordChangeFormKey.currentState!.validate()) {
        //remove loader
        EFullScreenLoader.stopLoading();
        return;
      }
      EFullScreenLoader.stopLoading();

      String pass1 = encryptString(password.text.trim());
      final newData = {
        'Password': pass1,
      };
      final ref = FirebaseDatabase.instance.ref().child("Project/UserRegister/$userId");
      await ref.update(newData);


      ELoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account Password has been Updated!');
      // Get.to(() => const NavigationMenu());
      Get.to(() => const ResetPassword());
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
  String encryptString(String originalString) {
    var bytes = utf8.encode(originalString); // Convert string to bytes
    var digest = sha256.convert(bytes); // Apply SHA-256 hash function
    return digest.toString(); // Return the hashed string
  }
}
