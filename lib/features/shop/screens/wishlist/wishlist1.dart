import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/icons/circular_icon.dart';
import 'package:ethnic_elegance/features/shop/models/wishlist_list_model.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home1.dart';
import 'package:ethnic_elegance/navigation_menu1.dart';
import 'package:ethnic_elegance/sharepreferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';

class FavouriteScreen1 extends StatefulWidget {
  const FavouriteScreen1({super.key});

  @override
  State<FavouriteScreen1> createState() => _FavouriteScreen1State();
}

class _FavouriteScreen1State extends State<FavouriteScreen1> {

  String? userid;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: EAppBar(
        title: Text("Wishlist", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ECircularIcon(icon: Iconsax.add, onPressed: () => Get.offAll(const HomeScreen1())),
        ],
      ),
      bottomNavigationBar: const NavigationMenu1(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              EWishList()
            ],
          ),
        ),
      ),
    );
  }
}
