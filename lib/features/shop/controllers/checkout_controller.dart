import 'package:flutter/material.dart';
import 'package:ethnic_elegance/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/network_manager.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();
  
  late List<String> cartId;
  late String getKeys;
  late String orderDate;
  late String subAmount;
  late String couponDiscount;
  late String shippingFee;
  late String taxFee;
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
