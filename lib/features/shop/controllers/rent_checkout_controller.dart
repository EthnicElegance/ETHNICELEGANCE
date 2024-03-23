import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/network_manager.dart';

class RentCheckoutController extends GetxController {
  static RentCheckoutController get instance => Get.find();
  
  late List<String> cartId;
  late String getKeys;
  late String orderDate;
  late String depositAmount;
  late String totalAmount;
  late String userAddress;

  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

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
