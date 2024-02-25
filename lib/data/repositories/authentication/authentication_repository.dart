import 'package:ethnic_elegance/features/authentication/screens/login/login.dart';
import 'package:ethnic_elegance/features/authentication/screens/screens.onboarding/onboarding.dart';
// import 'package:ethnic_elegance/features/authentication/screens/signup/verify_email.dart';
// import 'package:ethnic_elegance/navigation_menu.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import '../../../utils/exceptions/firebase_auth_exceptions.dart';
// import '../../../utils/exceptions/firebase_exceptions.dart';
// import '../../../utils/exceptions/format_exceptions.dart';
// import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  // final _auth = FirebaseAuth.instance;

  /// Called from main.dart on app loader
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// function to show relevant screen
  screenRedirect() async {
    // final user = _auth.currentUser;
    // if(user != null) {
    //   if(user.emailVerified){
    //     Get.offAll(() => const NavigationMenu());
    //   } else{
    //     Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
    //     // Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
    //   }
    // }else{
    //
    //   deviceStorage.writeIfNull('IsFirstTime', true);
    //   deviceStorage.read('IsFirstTime') != true
    //       ? Get.offAll(() => const LoginScreen())
    //       : Get.offAll(() => const OnBoardingScreen());
    // }
    /// local storage

    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read('isFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(const OnBoardingScreen());
  }

  /* ----- Email & Password sign in ---------*/

  /// [EmailAuth] -- signin

  /// [EmailAuth] -- REGISTER
  // Future<UserCredential> registerWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     return await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     throw TFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please Try again';
  //   }
  // }
  //
  // /// [ReAuth] -- ReAuthentication user
  //
  // /// [EmailV] -- Mail V
  // Future<void> sendEmailVerification() async {
  //   try {
  //     await _auth.currentUser?.sendEmailVerification();
  //   } on FirebaseAuthException catch (e) {
  //     throw TFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please Try again';
  //   }
  // }
  //
  // /// Logout
  // Future<void> logout() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     Get.offAll(() => const LoginScreen());
  //   } on FirebaseAuthException catch (e) {
  //     throw TFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please Try again';
  //   }
  // }

  /// [EmailV] -- Forgot Password
}
