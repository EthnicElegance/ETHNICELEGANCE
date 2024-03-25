import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/network_manager.dart';

class SearchController1 extends GetxController {
  static SearchController1 get instance => Get.find();


  final searchText = TextEditingController();
  late final text;


  GlobalKey<FormState> couponKey = GlobalKey<FormState>();

  void insertOrder() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();


      if (!isConnected) {
        return;
      }
    } catch (e) {
      ELoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
