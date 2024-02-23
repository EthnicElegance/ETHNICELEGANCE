import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();
  /// variables
  final pageController = PageController();
  Rx currentPageIndex = 0.obs;
  /// Update Current Index *hen Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;
  /// Jump to the specific dot selected page.
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }
  /// Update Current Index & jump to next page.
  void nextPage() {
    if(currentPageIndex.value == 2){
      Get.to(const LoginScreen());
    }else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }
  /// Update Current Index & jump to the last Page.
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}