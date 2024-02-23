import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/personalization/screens/profile/widgets/profile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../images/rounded_image.dart';

class EUerProfileTitle extends StatelessWidget {
  const EUerProfileTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ERoundedImage(
        imageUrl: EImages.lightAppLogo,
        height: 50,
        width: 50,
        padding: EdgeInsets.all(0),
      ),
      title: Text("Ethnic Elegance",style: Theme.of(context).textTheme.headlineSmall!.apply(color: EColors.white)),
      subtitle: Text("Ethnic Elegance",style: Theme.of(context).textTheme.bodyMedium!.apply(color: EColors.white)),
      trailing: IconButton(onPressed: () => Get.to(() => const ProfileScreen()), icon: const Icon(Iconsax.edit,color: EColors.white)),
    );
  }
}