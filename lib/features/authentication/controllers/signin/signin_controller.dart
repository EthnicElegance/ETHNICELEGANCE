import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
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
        print("------------------------------Data------------------------------");
        print(snapshot.snapshot.children.length);
        var encPassword = encryptString(password.text);
        // final scaffol
        //String msg = "Invalid Username or Password..! Please check..!!";
        Map data;
        var count = 0;
        await dbRef.once().then((documentSnapshot) async {
          for (var x in documentSnapshot.snapshot.children) {
            String? key = x.key;
            data = x.value as Map;
            if (data["Email"] == email.text &&
                data["Password"].toString() == encPassword) {
              //saveData('email', data["Email"]);
              //await saveData('email', data["Email"]);
              saveKey(key);
              //saveData('key', key);
              count = count + 1;
              // Navigator.pop(context);
              success();
            } else {
              //msg = "Sorry..! Wrong Username or Password";
              // EFullScreenLoader.stopLoading();
              ELoaders.errorSnackBar(
                  title: 'Oh snap!', message: "Wrong Password");
            }
          }
        });
      }
      // print(ss.);
      // ELoaders.errorSnackBar(title: 'Oh snap!', message: "Wrong Email");

      // EFullScreenLoader.stopLoading();

      //move to verify email screen
      // if (kDebugMode) {
      //   print('--------------------------Process is Start---------------------------------');
      // }
      // String pass1 = encryptString(password.text.trim());
      // var pass= password.text.trim();
      // if (kDebugMode) {
      //   print('password was $pass');
      // }
      // if (kDebugMode) {
      //   print('password was $pass1');
      // }
      // Query dbRef2 = FirebaseDatabase.instance
      //     .ref()
      //     .child('Project/UserRegister')
      //     .orderByChild("Email")
      //     .equalTo(email);
      // var count = 0;
      // // var msg = "Email does not exist";
      // Map data2;
      // if (kDebugMode) {
      //   print("Entering the loop");
      // }
      //
      // String? key;
      // await dbRef2.once().then((documentSnapshot) => {
      //       for (var x in documentSnapshot.snapshot.children)
      //         {
      //           key = x.key,
      //           data2 = x.value as Map,
      //
      //           print("Data = $data2"),
      //           print("Data = $key"),
      //
      // // print("key is $key"),
      //           if (pass1 == data2["Password"])
      //             {
      //               count = count + 1,
      //               saveData("key", key),
      //
      //
      //
      //             }
      //           else
      //             {
      //               count = count + 1,
      //               // EFullScreenLoader.stopLoading(),
      //               ELoaders.errorSnackBar(
      //                   title: 'Wrong Password',
      //                   message:
      //                       'Your account password is wrong! Enter the right Password to continue'
      //               ),
      //             }
      //
      //         }
      //     });
      // if (count == 0) {
      //   // EFullScreenLoader.stopLoading();
      //
      //   ELoaders.errorSnackBar(
      //       title: 'Email not found',
      //       message:
      //           'Your account Email address does not found! enter valid email to continue');
      // }

      // dbRef.push().set(regobj.toJson());

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
      /*//remove loader*/
      // EFullScreenLoader.stopLoading();
      //show error to user
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
    // finally {
    //   //remove loader
    //   EFullScreenLoader.stopLoading();
    // }
  }

  void success() {

    ELoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue');

    Get.offAll(() => const HomeScreen());
    //
    // Get.to(
    //   () =>  const NavigationMenu(),
    // );
  }

  String encryptString(String originalString) {
    var bytes = utf8.encode(originalString); // Convert string to bytes
    var digest = sha256.convert(bytes); // Apply SHA-256 hash function
    return digest.toString(); // Return the hashed string
  }
}
