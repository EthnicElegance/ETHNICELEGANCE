import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home1.dart';
import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/popups/full_screen_loader.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';

import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../sharepreferences.dart';
import '../../../../utils/helpers/network_manager.dart';

class SigninController extends GetxController {
  static SigninController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();


  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();


  //Signup
  void signin(BuildContext context) async {
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
      if (!signinFormKey.currentState!.validate()) {
        //remove loader
        EFullScreenLoader.stopLoading();
        return;
      }
      EFullScreenLoader.stopLoading();

      final dbRef =
      FirebaseDatabase.instance.ref().child('Project/UserRegister').orderByChild("Email").equalTo(email.text);
      final snapshot = await dbRef.once();

      // Check if any data was retrieved
      if (snapshot.snapshot.children.isEmpty) {
        // Handle empty dbRef case (e.g., display error message)
        ELoaders.errorSnackBar(title: 'Email not found', message: 'The provided email is not registered.');
        return;
      }else {

        var encPassword = encryptString(password.text);

        Map data;
        var count = 0;
        await dbRef.once().then((documentSnapshot) async {
          for (var x in documentSnapshot.snapshot.children) {
            String? key = x.key;
            data = x.value as Map;
            if (data["Email"] == email.text &&
                data["Password"].toString() == encPassword) {
              saveKey(key);

              count = count + 1;

              if(data['UserType'] == "Business Customer") {
                success();
              }else if(data['UserType'] == "Retail Customer"){
                success1();
              }
            } else {
              ELoaders.errorSnackBar(
                  title: 'Oh snap!', message: "Wrong Password");
            }
          }
        });
      }

    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  void success() {

    ELoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created!');

    Get.offAll(() => const HomeScreen());
  }
  void success1() {

    ELoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created!');

    Get.offAll(() => const HomeScreen1());
  }

  String encryptString(String originalString) {
    var bytes = utf8.encode(originalString); // Convert string to bytes
    var digest = sha256.convert(bytes); // Apply SHA-256 hash function
    return digest.toString(); // Return the hashed string
  }
}
