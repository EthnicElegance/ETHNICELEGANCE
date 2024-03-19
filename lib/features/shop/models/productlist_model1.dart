import 'dart:async';

import 'package:ethnic_elegance/features/shop/models/product_model.dart';
import 'package:ethnic_elegance/features/shop/models/wishlist_item.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/product_detail1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/styles/shadows.dart';
import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/icons/circular_icon.dart';
import '../../../common/widgets/texts/product_price_text.dart';
import '../../../common/widgets/texts/product_title_text.dart';
import '../../../sharepreferences.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/popups/loaders.dart';
import '../controllers/wishlist_service.dart';



class EProductList1 extends StatefulWidget {
  const EProductList1 ({super.key,this.limitedProduct = false,this.productCount, this.allProduct = true, this.productSubCat});

  final bool limitedProduct;
  final bool allProduct;
  final int? productCount;
  final String? productSubCat;

  @override
  State<EProductList1> createState() => _EProductList1State();
}

class _EProductList1State extends State<EProductList1> {

  late Query dbRef;
  late Query dbRefUser;
  String? userid;
  Map<int, Map> userMap = {};
  late Map data1;
  late Map data2;
  late List<Map> userName = [];
  Map<dynamic, dynamic>? userData;

  List<Map> appointment = [];

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
    });
  }

  Future<void> getHospitalData() async {

    appointment.clear();
    userMap.clear();
    dbRef = FirebaseDatabase.instance.ref().child('Project/wishlist');
    dbRef
        .orderByChild("userId")
        .equalTo(userid)
        .onValue
        .listen((event) async {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) async {
          appointment.add({
            'wishlistkey': key,
            'productId': value['productId'],
            "userId": value["userId"],
          });
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    getHospitalData();

    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 400,
        child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref().child("Project/product").orderByChild("retailer_price").equalTo("0").onValue,
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
                List<ProductModel> prodlist = [];
                prodlist.clear();
                map.forEach((dynamic key,dynamic v) {
                  if (v != null) {
                    if(v["customer_price"] != '0'){
                      prodlist.add(ProductModel(
                          key.toString(),
                          v["subcatid"],
                          v["product_name"],
                          v["photo1"],
                          v["photo2"],
                          v["photo3"],
                          v["customer_price"],
                          v["size"],
                          v["qty"],
                          v["product_colour"],
                          v["fabric"],
                          v["detail"],
                          v["DateTime"],
                          v["availability"]));
                    }
                  }
                });
                print("-------------------------------------prodlist------------------------------------------");
                print(prodlist);
                print(prodlist.length);
                final productIds = appointment.map((item) => item['productId']).toList();
                final wishlistIds = appointment.map((item) => item['wishlistkey']).toList();
                return GridView.builder(
                  itemCount: widget.limitedProduct ?widget.productCount : prodlist.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: ESizes.gridViewSpacing,
                    crossAxisSpacing: ESizes.gridViewSpacing,
                    mainAxisExtent: 280,
                  ),
                  itemBuilder: (BuildContext context,int index) {
                    if(prodlist[index].price != '0') {
                      String productId = prodlist[index].key;
                      final found = productIds.contains(productId);
                      var icon = found ? Iconsax.heart5 : Iconsax.heart;

                      return GestureDetector(
                        onTap: () =>
                            Get.to(() =>
                                ProductDetailScreen1(id: prodlist[index].key, index: index,)),
                        child: Container(
                          width: 180,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            boxShadow: [EShadowStyle.verticalProductShadow],
                            borderRadius: BorderRadius.circular(
                                ESizes.productImageRadius),
                            color: dark ? EColors.darkerGrey : EColors.white,
                          ),
                          child: Column(
                            children: [

                              ///Thumbnail
                              ERoundedContainer(
                                height: 180,
                                padding: const EdgeInsets.only(top: 5.0),
                                backgroundColor: dark ? EColors.dark : EColors
                                    .light,
                                child: Stack(
                                  children: [

                                    ///Thumbnail Image
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ESizes.md),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              ESizes.md),
                                          child: Image(
                                              image: NetworkImage(
                                                  "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${prodlist[index]
                                                      .pphoto1}?alt=media"),
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                    ),

                                    ///sale Tag
                                    // Positioned(
                                    //   top: 12,
                                    //   child: ERoundedContainer(
                                    //     radius: ESizes.sm,
                                    //     backgroundColor: EColors.secondary
                                    //         .withOpacity(0.8),
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: ESizes.sm,
                                    //         vertical: ESizes.xs),
                                    //     child: Text('25%',
                                    //         style: Theme
                                    //             .of(context)
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
                                        icon: icon, color: Colors.red,
                                        onPressed: () async {
                                          if (icon == Iconsax.heart) {
                                            setState(() {
                                              icon = Iconsax.heart5;
                                            });
                                            await WishlistService()
                                                .addToWishlist(WishlistItem(
                                                productId: prodlist[index].key,
                                                userId: userid));
                                            ELoaders.successSnackBar(
                                                title: 'Added to Wishlist',
                                                message: 'the product ${prodlist[index]
                                                    .pname} Added to Wishlist'
                                            );
                                          }
                                          else if (icon == Iconsax.heart5) {
                                            setState(() {
                                              icon = Iconsax.heart;
                                            });

                                            await WishlistService()
                                                .removeFromWishlist(
                                                wishlistIds.firstWhere((id) =>
                                                    productIds.contains(
                                                        prodlist[index].key)));
                                            ELoaders.successSnackBar(
                                                title: 'Removed from Wishlist',
                                                message: 'the product ${prodlist[index]
                                                    .pname} Removed from Wishlist'
                                            );
                                          }
                                        },
                                      ),
                                    )
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
                                      title: prodlist[index].pname,
                                      smallSize: true,
                                    ),
                                    const SizedBox(
                                        height: ESizes.spaceBtwItems / 2),
                                    Row(
                                      children: [
                                        Text(prodlist[index].availability,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .labelMedium),
                                        const SizedBox(height: ESizes.xs),
                                        const Icon(Iconsax.verify5,
                                            color: EColors.primary,
                                            size: ESizes.iconXs)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),

                              ///Price Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [

                                  ///Price
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: ESizes.sm),
                                    child: EProductPriceText(
                                        price: prodlist[index].price),
                                  ),

                                  ///Add To Cart
                                  // Container(
                                  //   decoration: const BoxDecoration(
                                  //     color: EColors.dark,
                                  //     borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(
                                  //           ESizes.cardRadiusMd),
                                  //       bottomRight:
                                  //       Radius.circular(
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
                    }
                    else{
                      return Container();
                    }
                  },
                );
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      strokeWidth: 1.5),
                );
              }
            }
        ),
      ),
    );
  }
}