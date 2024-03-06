import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ethnic_elegance/common/widgets/icons/circular_icon.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../sharepreferences.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/wishlist_service.dart';
import '../../../models/wishlist_item.dart';

class EProductImageSlider extends StatefulWidget {
  const EProductImageSlider({
    Key? key,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.productId,
  }) : super(key: key);

  final String image1, image2, image3, productId;

  @override
  State<EProductImageSlider> createState() => _EProductImageSliderState();
}

class _EProductImageSliderState extends State<EProductImageSlider> {
  late Query dbRef;
  String? userid;
  List<Map<String, dynamic>> wishList = [];
  late IconData icon;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
      getHospitalData1(); // Call after setting userid
    });
  }

  Future<void> getHospitalData1() async {
    wishList.clear();
    dbRef = FirebaseDatabase.instance.ref().child('Project/wishlist');
    dbRef
        .orderByChild("userId")
        .equalTo(userid)
        .onValue
        .listen((event) async {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) async {
          wishList.add({
            'wishlistkey': key,
            'productId': value['productId'],
            "userId": value["userId"],
          });
        });
        final productIds = wishList.map((item) => item['productId']).toList();
        final found = productIds.contains(widget.productId);
        setState(() {
          icon = found ? Iconsax.heart5 : Iconsax.heart;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);

    if (wishList.isEmpty) {
      // Handle empty list gracefully (e.g., show a placeholder or message)
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(Colors.black),
          strokeWidth: 1.5,
        ),
      );
    } else {
      return ECurvedEdgeWidget(
        child: Container(
          color: dark ? EColors.darkerGrey : EColors.light,
          child: Stack(
            children: [
              /// Main Large Image
              SizedBox(
                height: 400,
                child: Padding(
                  padding:
                  const EdgeInsets.all(ESizes.productImageRadius * 2),
                  child: Center(
                    child: Image(
                      image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${widget.image1}?alt=media",
                      ),
                    ),
                  ),
                ),
              ),

              ///Image Slider
              Positioned(
                right: 0,
                bottom: 30,
                left: ESizes.defaultSpace,
                child: SizedBox(
                  height: 80,
                  child: ListView.separated(
                    separatorBuilder: (_, __) =>
                    const SizedBox(width: ESizes.spaceBtwItems),
                    itemCount: 2,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.all(ESizes.sm),
                        decoration: BoxDecoration(
                          border: Border.all(color: EColors.primary),
                          color: dark ? EColors.dark : EColors.white,
                          borderRadius: BorderRadius.circular(ESizes.md),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(ESizes.md),
                          child: Image(
                            image: NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${widget.image2}?alt=media",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///AppBar Icons
              EAppBar(
                showBackArrow: true,
                actions: [
                  ECircularIcon(
                    icon: icon,
                    color: Colors.red,
                    onPressed: () async {
                      final foundItem = wishList.firstWhere(
                              (item) => item['productId'] == widget.productId,
                          orElse: () => {});
                      if (foundItem.isNotEmpty) {
                        final wishlistId = foundItem['wishlistkey'];
                        final found = icon == Iconsax.heart5;
                        if (found) {
                          await WishlistService()
                              .removeFromWishlist(wishlistId);
                          setState(() {
                            icon = Iconsax.heart;
                            wishList.removeWhere(
                                    (item) => item['wishlistkey'] == wishlistId);
                          });
                          ELoaders.successSnackBar(
                            title: 'Removed from Wishlist',
                            message: 'The product has been removed from Wishlist',
                          );
                        } else {
                          await WishlistService().addToWishlist(
                            WishlistItem(productId: widget.productId, userId: userid),
                          );
                          setState(() {
                            icon = Iconsax.heart5;
                            wishList.add({
                              'wishlistkey': wishlistId,
                              'productId': widget.productId,
                              'userId': userid
                            });
                          });
                          ELoaders.successSnackBar(
                            title: 'Added to Wishlist',
                            message: 'The product has been added to Wishlist',
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
