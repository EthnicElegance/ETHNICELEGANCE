import 'package:ethnic_elegance/features/shop/models/rent_product/rentproduct_model.dart';
import 'package:ethnic_elegance/features/shop/screens/rental_product_details/rental_product_detail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/shadows.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ERentProductList extends StatefulWidget {
  const ERentProductList({
    Key? key,
    this.limitedProduct = false,
    this.productCount,
    required this.productSubCat,
  }) : super(key: key);

  final bool limitedProduct;
  final int? productCount;
  final String productSubCat;

  @override
  State<ERentProductList> createState() => _ERentProductListState();
}

class _ERentProductListState extends State<ERentProductList> {
  late Query dbRef;
  String? userid;
  List<Map<String, dynamic>> appointment = [];

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
      //getWishlistData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 400,
        child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .ref()
              .child("Project/RentProduct")
              .orderByChild('catid')
              .equalTo(widget.productSubCat)
              .onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final Map<dynamic, dynamic>? map =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

              if (map == null || map.isEmpty) {
                return const Center(
                  child: Text(
                    'Up Coming Data',
                    style: TextStyle(fontSize: 10),
                  ),
                );
              }

              final List<RentProductModel> rentProdList = [];
              rentProdList.clear();

              map.forEach((key, v) {
                if (v != null) {
                  rentProdList.add(RentProductModel(
                    key,
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
                    v["availability"],
                  ));
                }
              });

              return GridView.builder(
                itemCount: widget.limitedProduct
                    ? widget.productCount
                    : rentProdList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: ESizes.gridViewSpacing,
                  crossAxisSpacing: ESizes.gridViewSpacing,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (BuildContext context, int index) {

                  return GestureDetector(
                    onTap: () => Get.to(() => RentalProductDetailScreen(
                      id: rentProdList[index].key,
                      index: index,
                    )),
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
                                        image: NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${rentProdList[index].rphoto1}?alt=media"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
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
                                  title: rentProdList[index].rname,
                                  smallSize: true,
                                ),
                                const SizedBox(height: ESizes.spaceBtwItems / 2),
                                Row(
                                  children: [
                                    Text(
                                      rentProdList[index].ravailability,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
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
                              Padding(
                                padding: const EdgeInsets.only(left: ESizes.sm),
                                child: EProductPriceText(
                                  price: rentProdList[index].rprice,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: ESizes.sm),
                              //   child: EProductPriceText(
                              //     price: "${double.parse(rentProdList[index].rprice)*5} Deposit",
                              //   ),
                              // ),
                            ],
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
                  strokeWidth: 2,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

