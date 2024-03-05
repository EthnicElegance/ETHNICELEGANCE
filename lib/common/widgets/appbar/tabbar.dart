import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/device/device_utility.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ETabBar extends StatelessWidget implements PreferredSizeWidget{
  
  const ETabBar({super.key, required this.tabs});
  
  final List<Widget> tabs;
   
  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? EColors.black : EColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: EColors.primary,
        labelColor: dark ? EColors.white : EColors.primary,
        unselectedLabelColor: EColors.darkerGrey,
      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
  
}