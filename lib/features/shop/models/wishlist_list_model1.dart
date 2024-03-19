import 'dart:async';
import 'package:ethnic_elegance/sharepreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/styles/shadows.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/icons/circular_icon.dart';
import '../../../common/widgets/texts/product_price_text.dart';
import '../../../common/widgets/texts/product_title_text.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/popups/loaders.dart';
import '../controllers/wishlist_service.dart';
import '../screens/product_details/product_detail.dart';
import '../screens/wishlist/wishlist.dart';

class EWishList1 extends StatefulWidget {
  const EWishList1({super.key});

  @override
  State<EWishList1> createState() => _EWishList1State();
}

class _EWishList1State extends State<EWishList1> {
  String? userid;
  late Query dbRef;
  late Query dbRefWish;
  late StreamController<List<Map>> _streamController;
  Map<dynamic, dynamic>? userData;
  Map<int, Map> prodMap = {};
  late Map data1;
  late Map data2;
  late List<Map> productList = [];
  
  List<Map> wishList = [];

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
    });
  }

  Future<void> getWishListData() async {
    _streamController = StreamController<List<Map>>();
    wishList.clear();
    prodMap.clear();
    dbRef = FirebaseDatabase.instance.ref().child('Project/wishlist');
    dbRef.orderByChild("userId").equalTo(userid).onValue.listen((event) async {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        var productId;
        values.forEach((key, value) async {
          productId = value["productId"];
          wishList.add({
            'wishlistkey': key,
            'productId': value['productId'],
            "userId": value["userId"],
          });
          await fetchProductData(productId, wishList.length - 1);
        });
      }
      _streamController.add(wishList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    getWishListData();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 400,
        child: StreamBuilder<List<Map>>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map>? wlist = snapshot.data;
              return GridView.builder(
                itemCount: wlist!.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: ESizes.gridViewSpacing,
                  crossAxisSpacing: ESizes.gridViewSpacing,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (context, index) {
                  data1 = wlist[index];
                  data2 = prodMap[index] ?? {};
                  if (data1.isNotEmpty && data2.isNotEmpty) {
                    return GestureDetector(
                      onTap: () => Get.to(
                          () => ProductDetailScreen(id: wlist[index]['productId'],index: index,)),
                      child: Container(
                        width: 180,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          boxShadow: [EShadowStyle.verticalProductShadow],
                          borderRadius:
                              BorderRadius.circular(ESizes.productImageRadius),
                          color: dark ? EColors.darkerGrey : EColors.white,
                        ),
                        child: Column(
                          children: [
                            ///Thumbnail
                            ERoundedContainer(
                              height: 180,
                              padding: const EdgeInsets.all(ESizes.sm),
                              backgroundColor:
                                  dark ? EColors.dark : EColors.light,
                              child: Stack(
                                children: [
                                  ///Thumbnail Image
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(ESizes.md),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(ESizes.md),
                                        child: Image(
                                            image: NetworkImage(
                                                "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${data2['photo1']}?alt=media"),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),

                                  ///sale Tag
                                  // Positioned(
                                  //   top: 12,
                                  //   child: ERoundedContainer(
                                  //     radius: ESizes.sm,
                                  //     backgroundColor:
                                  //         EColors.secondary.withOpacity(0.8),
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: ESizes.sm,
                                  //         vertical: ESizes.xs),
                                  //     child: Text('25%',
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .labelLarge!
                                  //             .apply(color: EColors.black)),
                                  //   ),
                                  // ),

                                  /// Favourite Icon Button
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: ECircularIcon(
                                      icon: Iconsax.heart5,
                                      color: Colors.red,
                                      onPressed: () async {
                                        String wishlistId =
                                            wlist[index]['wishlistkey'];
                                        await WishlistService()
                                            .removeFromWishlist(wishlistId);
                                        ELoaders.successSnackBar(
                                            title: 'Removed from Wishlist',
                                            message: 'the product has been Removed from Wishlist'
                                        );
                                        Get.offAll(
                                            () => const FavouriteScreen());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: ESizes.spaceBtwItems / 2),

                            ///details
                            Padding(
                              padding: const EdgeInsets.only(left: ESizes.sm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EProductTitleText(
                                    title: data2['product_name'],
                                    smallSize: true,
                                  ),
                                  const SizedBox(
                                      height: ESizes.spaceBtwItems / 2),
                                  Row(
                                    children: [
                                      Text(data2['availability'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      const SizedBox(height: ESizes.xs),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),

                            ///Price Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///Price
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: ESizes.sm),
                                  child: EProductPriceText(
                                      price: data2['customer_price']),
                                ),

                                ///Add To Cart
                                // Container(
                                //   decoration: const BoxDecoration(
                                //     color: EColors.dark,
                                //     borderRadius: BorderRadius.only(
                                //       topLeft:
                                //           Radius.circular(ESizes.cardRadiusMd),
                                //       bottomRight: Radius.circular(
                                //           ESizes.productImageRadius),
                                //     ),
                                //   ),
                                //   child: const SizedBox(
                                //     width: ESizes.iconLg * 1.2,
                                //     height: ESizes.iconLg * 1.2,
                                //     child: Center(
                                //       child: Icon(
                                //         Iconsax.add,
                                //         color: EColors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      strokeWidth: 1.5,
                    ));
                  }
                },
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                strokeWidth: 1.5,
              ));
            }
          },
        ),
      ),
    );
  }

  Future<void> fetchProductData(String key, int index) async {
    DatabaseReference dbUserData =
        FirebaseDatabase.instance.ref().child("Project/product").child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    prodMap[index] = {
      "product_name": userData!["product_name"],
      "photo1": userData!["photo1"],
      "photo2": userData!["photo2"],
      "photo3": userData!["photo3"],
      "customer_price": userData!["customer_price"],
      "size": userData!["size"],
      "qty": userData!["qty"],
      "product_colour": userData!["product_colour"],
      "fabric": userData!["fabric"],
      "detail": userData!["detail"],
      "availability": userData!["availability"]
    };
    _streamController.add(wishList); // Update the stream with new data
  }
}
