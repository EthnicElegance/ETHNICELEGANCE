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
    super.key, required this.image1, required this.image2, required this.image3, required this.productId,

  });
  final String image1,image2,image3,productId;

  @override
  State<EProductImageSlider> createState() => _EProductImageSliderState();
}

class _EProductImageSliderState extends State<EProductImageSlider> {
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
    final productIds = appointment.map((item) => item['productId']).toList();
    final wishlistIds = appointment.map((item) => item['wishlistkey']).toList();

    String productId = widget.productId;
    final found = productIds.contains(productId);
    var icon = found ? Iconsax.heart5 : Iconsax.heart;

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
                          image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${widget.image1}?alt=media")))),
            ),

            ///Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: ESizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(width: ESizes.spaceBtwItems),
                  itemCount: 1,
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
                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${widget.image2}?alt=media"),
                            fit: BoxFit.contain),
                      ),
                    ),
                    )
                  )
                ),
              ),

            ///AppBar Icons
            EAppBar(
              showBackArrow: true,
              actions: [
                ECircularIcon(icon: icon, color: Colors.red,
                    onPressed: ()  async {
                      if(icon == Iconsax.heart){
                        setState(() {
                          icon = Iconsax.heart5;
                        });
                        await WishlistService().addToWishlist(WishlistItem(productId: widget.productId, userId: userid));
                        ELoaders.successSnackBar(
                            title: 'Added to Wishlist',
                            message: 'the product has been Added to Wishlist'
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to Wishlist')));
                      }
                      else if(icon == Iconsax.heart5){
                        setState(() {
                          icon = Iconsax.heart;
                        });
                        await WishlistService()
                            .removeFromWishlist(
                            wishlistIds.firstWhere((id) => productIds.contains(widget.productId)));
                        ELoaders.successSnackBar(
                            title: 'Removed from Wishlist',
                            message: 'the product has been Removed from Wishlist'
                        );
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