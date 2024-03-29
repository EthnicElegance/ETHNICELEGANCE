import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/constants/image_strings.dart';
import 'package:ethnic_elegance/utils/popups/full_screen_loader.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../models/address_model.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  
  late String getKeys;
  final name = TextEditingController();
  final contact = TextEditingController();
  final address = TextEditingController();
  final pincode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  DatabaseReference dbRef =
  FirebaseDatabase.instance.ref().child('Project/Address');

  void insertAddress() async {
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
      if (!addressKey.currentState!.validate()) {
        //remove loader
        EFullScreenLoader.stopLoading();
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      getKeys = prefs.getString('key')!;
      AddressModel regobj = AddressModel(
          getKeys,
          name.text.trim(),
          contact.text.trim(),
          address.text.trim(),
          pincode.text.trim(),
          city.text.trim(),
          state.text.trim(),
      );
      dbRef.push().set(regobj.toJson());

      EFullScreenLoader.stopLoading();

      ELoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Address is saved');
      // Get.back();
      Get.back();
      // Get.to(() => const NavigationMenu());
      // Get.offAll(
      //       () => Get.back()
      // );
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
