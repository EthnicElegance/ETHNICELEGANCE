import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class EVerticalImageText extends StatelessWidget {
  const EVerticalImageText({
    super.key, required this.image, required this.title, this.textColor = EColors.white, this.backgroundColor = EColors.white, this.onTap,
  });
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ESizes.spaceBtwItems),
        child: Column(
          children: [
            ///Circular Icon
            Container(
              width: 53,
              height: 65,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: backgroundColor ?? ( dark ? EColors.black : EColors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image(
                  image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/CategoryImage%2F$image?alt=media"),

                  fit: BoxFit.cover,
                  // color: EColors.black,
                ),
              ),
            ),

            ///Text
            const SizedBox(
              height: ESizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: 55,
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
