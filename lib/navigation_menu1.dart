import 'package:ethnic_elegance/features/personalization/screens/settings/settings1.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home1.dart';
import 'package:ethnic_elegance/features/shop/screens/rental/rental.dart';
import 'package:ethnic_elegance/features/shop/screens/wishlist/wishlist1.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'features/shop/screens/store/store1.dart';


class NavigationMenu1 extends StatefulWidget {
  const NavigationMenu1({super.key});

  @override
  State<NavigationMenu1> createState() => _NavigationMenu1State();
}

class _NavigationMenu1State extends State<NavigationMenu1> {
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index==0)
    {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen1()));
    }
    else if (index==1)
    {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const StoreScreen1()));
    }
    else if (index==2)
    {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const RentalScreen()));
    }
    else if (index==3)
    {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const FavouriteScreen1()));
    }
    else if (index==4)
    {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SettingsScreen1()));
    }
    else
    {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen1()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);

    return  BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Iconsax.home),
          label: 'Home',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.shop),
          label: 'Store',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.bag),
          label: 'Rent',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.heart),
          label: 'Wishlist',
          backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.user),
          label: 'Profile',
          backgroundColor: Colors.yellow,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: darkMode ? EColors.white : EColors.black ,
      onTap: _onItemTapped,
      elevation: 0,
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: darkMode ? EColors.black : EColors.white, //
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs ;

  final screens = [
    const HomeScreen1(),
    const StoreScreen1(),
    const RentalScreen(),
    const FavouriteScreen1(),
    const SettingsScreen1()
  ];

}
