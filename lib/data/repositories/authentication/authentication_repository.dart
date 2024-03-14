import 'package:ethnic_elegance/features/authentication/screens/login/login.dart';
import 'package:ethnic_elegance/features/authentication/screens/screens.onboarding/onboarding.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/shop/screens/home/home.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  late String getKeys;
  // late bool containsKey;


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
        ? chkUser()
        : Get.offAll(() => const OnBoardingScreen());
  }

  Future<void> chkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getKeys = prefs.getString('key')!;

    // print("----------------getKeys-------------------");
    // print(getKeys);
    final dbRef =
    FirebaseDatabase.instance.ref().child('Project/UserRegister').child(getKeys);
    final DatabaseEvent snapshot = await dbRef.once();
 // print(snapshot.snapshot.value);
    var dt= snapshot.snapshot.value as Map;
    String? userType = dt['UserType'];

    // if (userType != null) {
    //   print('UserType: $userType');
    // } else {
    //   print('UserType is null.');
    // }
    if (snapshot.snapshot.children.isEmpty) {
      // Handle empty dbRef case (e.g., display error message)
      // print("------------------------------Login------------------------------");
      Get.offAll(() => const LoginScreen());
    }else {
      // print("------------------------------Data1------------------------------");
      // print(snapshot.snapshot.children.length);
          if(userType == "Retail Customer"){

              Get.offAll(() => const HomeScreen1());

          }else if(userType == "Business Customer"){
              Get.offAll(() => const HomeScreen());
          }
    }
    // containsKey = prefs.containsKey('key');
    // if (containsKey) {
    //   // if(userType == "Retail Customer") {
    //   //   Get.offAll(() => const HomeScreen1());
    //   // }else {
    //     Get.offAll(() => const HomeScreen());
    //   // }
    // }else{
    //   Get.offAll(() => const LoginScreen());
    // }
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
