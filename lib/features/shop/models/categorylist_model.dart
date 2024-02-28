import 'package:ethnic_elegance/features/shop/screens/sub_category/subcategory.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/icons/brand_title_text_with_verified_iconn.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import 'category_model.dart';

class ECategoryList extends StatelessWidget {
  const ECategoryList(
      {super.key, this.limitedCategory = false, this.categoryCount});

  final bool limitedCategory;
  final int? categoryCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child("Project/category")
                .onValue,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                List<CategoryModel> catlist = [];
                catlist.clear();
                map.forEach((dynamic, v) => catlist.add(CategoryModel(
                      dynamic.toString(),
                      v["name"],
                      v["photo"],
                      v["gender"],
                    )));

                return GridView.builder(
                  itemCount: limitedCategory ? categoryCount : catlist.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: ESizes.gridViewSpacing,
                    crossAxisSpacing: ESizes.gridViewSpacing,
                    mainAxisExtent: 80,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => ESubCategoryScreen(
                            id: catlist[index].key,
                          )),
                      child: ERoundedContainer(
                        padding: const EdgeInsets.all(ESizes.sm),
                        showBorder: true,
                        backgroundColor: Colors.transparent,
                        child: Row(
                          children: [
                            ///Icon
                            Flexible(
                                child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                  child: Image(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/CategoryImage%2F${catlist[index].cphoto}?alt=media"),
                                // color: EHelperFunctions.isDarkMode(context) ? EColors.white : EColors.black,
                              )),
                            )),
                            const SizedBox(width: ESizes.spaceBtwItems / 2),

                            /// Text

                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EBrandTitleWithVerifiedIcon(
                                      title: catlist[index].cname,
                                      brandTextSize: TextSizes.large),
                                  Text(
                                    catlist[index].gen,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      strokeWidth: 1.5),
                );
              }
            }),
      ),
    );
  }
}
