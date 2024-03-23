import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/network_manager.dart';

class CouponController extends GetxController {
  static CouponController get instance => Get.find();


  final couponName = TextEditingController();


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
