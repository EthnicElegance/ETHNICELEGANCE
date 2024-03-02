import 'package:ethnic_elegance/features/shop/models/product_model.dart';
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
import '../screens/product_details/product_detail.dart';

class EProductList extends StatelessWidget {
  const EProductList ({super.key,this.limitedProduct = false,this.productCount, this.allProduct = true, this.productSubCat});

  final bool limitedProduct;
  final bool allProduct;
  final int? productCount;
  final String? productSubCat;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 400,
        child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref().child("Project/product").onValue,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {

                Map<dynamic, dynamic> map = snapshot.data.snapshot
                    .value;

                if (map.isEmpty) {
                  return const Center(
                    child: Text(
                      'Up Comming Data',
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                }
                List<ProductModel> prodlist = [];
                prodlist.clear();
                map.forEach((dynamic key,dynamic v) {
                  if (v != null) {
                    prodlist.add(ProductModel(
                        key.toString(),
                        v["subcatid"],
                        v["product_name"],
                        v["photo1"],
                        v["photo2"],
                        v["photo3"],
                        v["retailer_price"],
                        v["size"],
                        v["qty"],
                        v["product_colour"],
                        v["fabric"],
                        v["detail"],
                        v["DateTime"],
                        v["availability"]));
                  }
                });

                return GridView.builder(
                  itemCount: limitedProduct ? productCount : prodlist.length,
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
                    return GestureDetector(
                      onTap: () => Get.to(() => ProductDetailScreen(id: prodlist[index].key,)),
                      child: Container(
                        width: 180,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          boxShadow: [EShadowStyle.verticalProductShadow],
                          borderRadius: BorderRadius.circular(ESizes.productImageRadius),
                          color: dark ? EColors.darkerGrey : EColors.white,
                        ),
                        child: Column(
                          children: [

                            ///Thumbnail
                            ERoundedContainer(
                              height: 180,
                              padding: const EdgeInsets.only(top: 5.0),
                              backgroundColor: dark ? EColors.dark : EColors.light,
                              child: Stack(
                                children: [

                                  ///Thumbnail Image
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(ESizes.md),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(ESizes.md),
                                        child: Image(
                                            image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${prodlist[index].pphoto1}?alt=media"),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),

                                  ///sale Tag
                                  Positioned(
                                    top: 12,
                                    child: ERoundedContainer(
                                      radius: ESizes.sm,
                                      backgroundColor: EColors.secondary.withOpacity(0.8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: ESizes.sm, vertical: ESizes.xs),
                                      child: Text('25%',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .labelLarge!
                                              .apply(color: EColors.black)),
                                    ),
                                  ),

                                  /// Favourite Icon Button
                                  const Positioned(
                                    top: 0,
                                    right: 0,
                                    child: ECircularIcon(
                                        icon: Iconsax.heart5, color: Colors.red),
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
                                    title: prodlist[index].pname,
                                    smallSize: true,
                                  ),
                                  const SizedBox(height: ESizes.spaceBtwItems / 2),
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
                                          color: EColors.primary, size: ESizes.iconXs)
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
                                  padding: const EdgeInsets.only(left: ESizes.sm),
                                  child: EProductPriceText(price: prodlist[index].price),
                                ),

                                ///Add To Cart
                                Container(
                                  decoration: const BoxDecoration(
                                    color: EColors.dark,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(ESizes.cardRadiusMd),
                                      bottomRight:
                                      Radius.circular(ESizes.productImageRadius),
                                    ),
                                  ),
                                  child: const SizedBox(
                                    width: ESizes.iconLg * 1.2,
                                    height: ESizes.iconLg * 1.2,
                                    child: Center(
                                      child: Icon(
                                        Iconsax.add,
                                        color: EColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
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

// Padding EProductList() {
//   return
// }
