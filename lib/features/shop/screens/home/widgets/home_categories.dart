import 'package:flutter/material.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';

class EHomeCategories extends StatelessWidget {
  const EHomeCategories({
    super.key,
  });

  // final List<String> category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Row(children: [
              EVerticalImageText(
                image: EImages.sportIcon,
                title: 'Shoes',
                onTap: () {},
              ),EVerticalImageText(
                image: EImages.sportIcon,
                title: 'Shoes',
                onTap: () {},
              ),EVerticalImageText(
                image: EImages.sportIcon,
                title: 'Shoes',
                onTap: () {},
              ),EVerticalImageText(
                image: EImages.sportIcon,
                title: 'Shoes',
                onTap: () {},
              ),EVerticalImageText(
                image: EImages.sportIcon,
                title: 'Shoes',
                onTap: () {},
              ),EVerticalImageText(
                image: EImages.sportIcon,
                title: 'Shoes',
                onTap: () {},
              ),
            ]);
          },
        ),
      ),
    );
  }
}
