import 'package:ethnic_elegance/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/rent_product/rentproduct_model.dart';

class EProductImageSlider1 extends StatefulWidget {
  const EProductImageSlider1({
    Key? key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.productId,
    this.index,
  }) : super(key: key);

  final String image1, image2, image3, productId;
  final index;

  @override
  State<EProductImageSlider1> createState() => _EProductImageSlider1State();
}

class _EProductImageSlider1State extends State<EProductImageSlider1> {
  late Query dbRef;
  String? userid;
  bool isProductInWishlist = false;
  String? wishlistKey;
  int selectedImageIndex = 0;

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
    final dark = EHelperFunctions.isDarkMode(context);
    return ECurvedEdgeWidget(
      child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref()
              .child('Project/RentProduct')
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

              if (map.isEmpty) {
                return const Center(
                  child: Text(
                    'Up Coming Data',
                    style: TextStyle(fontSize: 10),
                  ),
                );
              }
              List<RentProductModel> prodlist = [];
              prodlist.clear();

              map.forEach((dynamic key, dynamic v) {
                if (v != null) {
                  prodlist.add(RentProductModel(
                      key.toString(),
                      v["catid"],
                      v["RentProduct_name"],
                      v["photo1"],
                      v["photo2"],
                      v["photo3"],
                      v["price"],
                      v["size"],
                      v["qty"],
                      v["RentProduct_colour"],
                      v["fabric"],
                      v["RentProduct_detail"],
                      v["DateTime"],
                      v["availability"]));
                }
              });

              int imageCount = 2;

              if (widget.image3 == "") {
                imageCount = 1;
              } else {
                imageCount = 2;
              }
              return Container(
                color: dark ? EColors.darkerGrey : EColors.light,
                child: Stack(
                  children: [
                    /// Main Large Image
                    SizedBox(
                      height: 400,
                      child: Padding(
                          padding: const EdgeInsets.all(
                              ESizes.productImageRadius * 2),
                          child: Center(
                              child: Image(
                                  image: NetworkImage(
                                      selectedImageIndex == 0
                                          ? "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image1}?alt=media"
                                          : selectedImageIndex == 1
                                          ? "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image2}?alt=media"
                                          : "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image3}?alt=media"
                                  )))),
                    ),

                    ///Image Slider
                    if (imageCount == 1)
                      Positioned(
                        right: 0,
                        bottom: 30,
                        left: ESizes.defaultSpace,
                        child: SizedBox(
                          height: 100,
                          child: ListView.separated(
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: ESizes.spaceBtwItems),
                              itemCount: 2,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                if (index == 0) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = 0;
                                      });
                                    },
                                    child: ERoundedImage(
                                      width: 80,
                                      fit: BoxFit.fill,
                                      backgroundColor:
                                          dark ? EColors.dark : EColors.white,
                                      border: Border.all(color: EColors.primary),
                                      padding: const EdgeInsets.all(0),
                                      isNetworkImage: true,
                                      imageUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image1}?alt=media",
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = 1;
                                      });
                                    },
                                    child: ERoundedImage(
                                      width: 80,
                                      fit: BoxFit.fill,
                                      backgroundColor:
                                          dark ? EColors.dark : EColors.white,
                                      border: Border.all(color: EColors.primary),
                                      padding: const EdgeInsets.all(0),
                                      isNetworkImage: true,
                                      imageUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image2}?alt=media",
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),

                    if (imageCount == 2)
                      Positioned(
                        right: 0,
                        bottom: 30,
                        left: ESizes.defaultSpace,
                        child: SizedBox(
                          height: 100,
                          // height: 350,
                          child: ListView.separated(
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: ESizes.spaceBtwItems),
                              itemCount: 3,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                if (index == 0) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = 0;
                                      });
                                    },
                                    child: ERoundedImage(
                                      width: 80,
                                      fit: BoxFit.fill,
                                      backgroundColor:
                                          dark ? EColors.dark : EColors.white,
                                      border: Border.all(color: EColors.primary),
                                      padding: const EdgeInsets.all(0),
                                      isNetworkImage: true,
                                      imageUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image1}?alt=media",
                                    ),
                                  );
                                }else if (index == 1) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = 1;
                                      });
                                    },
                                    child: ERoundedImage(
                                      width: 80,
                                      fit: BoxFit.fill,
                                      backgroundColor:
                                          dark ? EColors.dark : EColors.white,
                                      border: Border.all(color: EColors.primary),
                                      padding: const EdgeInsets.all(0),
                                      isNetworkImage: true,
                                      imageUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image2}?alt=media",
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = 2;
                                      });
                                    },
                                    child: ERoundedImage(
                                      // width: 280,
                                      width: 80,
                                      fit: BoxFit.fill,
                                      backgroundColor:
                                          dark ? EColors.dark : EColors.white,
                                      border: Border.all(color: EColors.primary),
                                      padding: const EdgeInsets.all(0),
                                      isNetworkImage: true,
                                      imageUrl:
                                          "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${widget.image3}?alt=media",
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),

                    ///AppBar Icons
                    const EAppBar(
                      showBackArrow: true,
                    ),
                  ],
                ),
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
    );
  }
}
