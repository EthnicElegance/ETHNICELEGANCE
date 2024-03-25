import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ESearchContainer extends StatelessWidget {
  const ESearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorer = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: ESizes.defaultSpace),

  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorer;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ESizes.defaultSpace),
        child: Container(
          width: EDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? EColors.dark
                    : EColors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(ESizes.cardRadiusLg),
            border: showBorer ? Border.all(color: EColors.grey) : null,
          ),
          child: SearchBar(
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(EColors.white),
            leading: const Icon(Icons.search),
            hintText: "Search",
            onChanged:(value) {},
          ),
          // child: Row(
          //   children: [
          //     Icon(
          //       icon,
          //       color: EColors.darkerGrey,
          //     ),
          //     const SizedBox(
          //       width: ESizes.spaceBtwItems,
          //     ),
          //     Text(
          //       text,
          //       style: Theme.of(context).textTheme.bodySmall,
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
  // void _filterEvents(String searchText) {
  //   filteredEvents.clear();
  //   search = searchText;
  //   if (searchText.isEmpty) {
  //     filteredEvents.addAll(eventlist);
  //   } else {
  //     filteredEvents.addAll(eventlist.where((event) =>
  //         event.e_name.toLowerCase().contains(searchText.toLowerCase())));
  //     filteredEvents.addAll(eventlist.where((event) =>
  //         event.location.toLowerCase().contains(searchText.toLowerCase())));
  //     filteredEvents.addAll(eventlist.where((event) =>
  //         event.l_address.toLowerCase().contains(searchText.toLowerCase())));
  //     // print(filteredEvents);
  //   }
  //   setState(() {});
  // }
}
