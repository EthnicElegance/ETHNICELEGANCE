import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ethnic_elegance/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ethnic_elegance/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/sizes.dart';

class ProductDetailScreen1 extends StatefulWidget {
  const ProductDetailScreen1({super.key, required this.id, this.index});
  final String id;
  final index;

  @override
  State<ProductDetailScreen1> createState() => _ProductDetailScreen1State();
}

class _ProductDetailScreen1State extends State<ProductDetailScreen1> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref().child("Project/product/${widget.id}").onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {

              final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

              return Column(
                children: [

                  /// 1-Product Image Slider
                  EProductImageSlider(image1: data['photo1'],image2: data['photo2'],image3: data['photo3'] ?? "",productId: widget.id,index: widget.index,),

                  /// 2- Product Details
                  Padding(
                    padding: const EdgeInsets.only(right: ESizes.defaultSpace,
                        left: ESizes.defaultSpace,
                        bottom: ESizes.defaultSpace),
                    child: Column(
                      children: [

                        /// Rating & Share Button
                        const ERatingAndShare(),

                        /// Price, Title, Stock & Brand
                        EProductMetaData(
                          price: data['customer_price'],
                          details: data['detail'],
                          name: data['product_name'],
                          photo1: data['photo1'],
                          photo2: data['photo2'],
                          photo3: data['photo3'],
                          availability: data['availability'],
                          colour: data['product_colour'],
                          size: data['size'],
                          fabric: data['fabric'],),

                        /// Attributes
                        EProductAttributes(colour: data['product_colour'],price:data['customer_price'],details: data['detail'],fabric: data['fabric'],id: widget.id),
                        const SizedBox(height: ESizes.spaceBtwSections),

                        /// Checkout Button
                        // SizedBox(width: double.infinity, child: ElevatedButton(
                        //     onPressed: () {}, child: const Text('Checkout'))),
                        // const SizedBox(height: ESizes.spaceBtwSections),

                        /// Description
                        const ESectionHeading(
                          title: 'Description', showActionButton: false,),
                        const SizedBox(height: ESizes.spaceBtwItems),
                        ReadMoreText(
                          data["detail"],
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: const TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w800),
                          lessStyle: const TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),

                        /// Reviews
                        const Divider(),
                        const SizedBox(height: ESizes.spaceBtwItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ESectionHeading(
                                title: 'Reviews(199)', showActionButton: false),
                            IconButton(icon: const Icon(
                                Iconsax.arrow_right_3, size: 18),
                                onPressed: () =>
                                    Get.to(() => const ProductReviewsScreen())),
                          ],
                        ),
                        const SizedBox(height: ESizes.spaceBtwSections),

                      ],
                    ),
                  ),
                ],
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
      bottomNavigationBar: EBottomAddToCart(id: widget.id, index: widget.index,),
    );
  }
}


