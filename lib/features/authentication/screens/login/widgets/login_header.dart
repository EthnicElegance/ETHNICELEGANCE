import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class ELoginHeader extends StatelessWidget {
  const ELoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? EImages.darkAppLogo : EImages.lightAppLogo),
        ),
        Text(ETexts.loginTitle, style: Theme.of(context).textTheme.headlineLarge,),
        const SizedBox(height: ESizes.sm),
        Text(ETexts.loginSubTitle,style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
