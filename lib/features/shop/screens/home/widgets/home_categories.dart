import 'package:ethnic_elegance/features/shop/screens/sub_category/subcategory.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../models/category_model.dart';

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
        child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child("Project/category")
                .onValue,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic> map = snapshot.data
                    .snapshot
                    .value;
                List<CategoryModel> catlist = [];
                catlist.clear();
                map.forEach((dynamic, v) =>
                    catlist.add(CategoryModel(
                      dynamic.toString(),
                      v["name"],
                      v["photo"],
                      v["gender"],
                    )));
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context,
                      int index) {
                    return EVerticalImageText(
                      image: catlist[index].cphoto,
                      title: catlist[index].cname,
                      onTap: () => Get.to(() => subCategoryScreen(id: catlist[index].key)),);
                  },
                );
              }
              else{
                return const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 1.5);
              }
            }
        ),
      ),
    );
  }
}
