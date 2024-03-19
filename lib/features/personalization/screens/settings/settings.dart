import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ethnic_elegance/common/widgets/layouts/list_tiles/settings_menu_tile.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/authentication/screens/login/login.dart';
import 'package:ethnic_elegance/features/personalization/screens/FAQs/faqscreen.dart';
import 'package:ethnic_elegance/features/shop/screens/cart/cart.dart';
import 'package:ethnic_elegance/features/shop/screens/order/order.dart';
import 'package:ethnic_elegance/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/widgets/layouts/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../address/address.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavigationMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EPrimaryHeaderContainer(
              child: Column(
                children: [
                  EAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: EColors.white),
                    ),
                  ),
                  const EUerProfileTitle(),
                  const SizedBox(height: ESizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  const ESectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: ESizes.spaceBtwItems),
                  ESettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen())
                  ),
                  ESettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'add,remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  ESettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  ESettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List of all discounted coupons',
                    onTap: () {},
                  ),

                  ESettingsMenuTile(
                    icon: Iconsax.message_question,
                    title: 'FAQs',
                    subtitle: 'List of all the FAQs',
                    onTap: () => Get.to(() => const FaqScreen()),
                  ),
                  
                  const SizedBox(height: ESizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Get.offAll(() => const LoginScreen());
                          }, child: const Text('Logout')),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
