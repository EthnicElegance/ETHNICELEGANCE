import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';

class EHomeAppBar extends StatefulWidget {
  const EHomeAppBar({super.key});

  @override
  State<EHomeAppBar> createState() => _EHomeAppBarState();
}

class _EHomeAppBarState extends State<EHomeAppBar> {

  @override
  Widget build(BuildContext context) {
    return EAppBar(
      title:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    // Text("EthnicElegance", style: Theme
                    //     .of(context)
                    //     .textTheme
                    //     .labelMedium!
                    //     .apply(color: EColors.grey)),
                // for (var entry in snapshot.data!.entries)
                //   if(entry.key == 'FirstName' || entry.key == 'LastName')
                Text("EthnicElegance", style: Theme
                    .of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: EColors.white)),
              ],
            ),
      actions: const [
        ECartCounterIcon(iconColor: EColors.white,)
      ],
    );
  }
}
