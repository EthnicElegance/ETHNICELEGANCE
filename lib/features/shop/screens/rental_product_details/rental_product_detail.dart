import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/features/shop/screens/rental_product_details/widgets/bottom_add_to_cart_widget1.dart';
import 'package:ethnic_elegance/features/shop/screens/rental_product_details/widgets/product_attributes1.dart';
import 'package:ethnic_elegance/features/shop/screens/rental_product_details/widgets/product_detail_image_slider1.dart';
import 'package:ethnic_elegance/features/shop/screens/rental_product_details/widgets/product_meta_data1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../../../utils/constants/sizes.dart';

class RentalProductDetailScreen extends StatefulWidget {
  const RentalProductDetailScreen({super.key, required this.id, this.index});
  final String id;
  final index;

  @override
  State<RentalProductDetailScreen> createState() => _RentalProductDetailScreenState();
}

class _RentalProductDetailScreenState extends State<RentalProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref().child("Project/RentProduct/${widget.id}").onValue,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {

              final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

              return Column(
                children: [

                  /// 1-Product Image Slider
                  EProductImageSlider1(image1: data['photo1'],image2: data['photo2'],image3: data['photo3'],productId: widget.id,index: widget.index,),

                  /// 2- Product Details
                  Padding(
                    padding: const EdgeInsets.only(right: ESizes.defaultSpace,
                        left: ESizes.defaultSpace,
                        bottom: ESizes.defaultSpace),
                    child: Column(
                      children: [

                        /// Price, Title, Stock & Brand

                        EProductMetaData1(
                          price: data['price'],
                          details: data['RentProduct_detail'],
                          name: data['RentProduct_name'],
                          photo1: data['photo1'],
                          photo2: data['photo2'],
                          photo3: data['photo3'],
                          availability: data['availability'],
                          colour: data['RentProduct_colour'],
                          size: data['size'],
                          fabric: data['fabric'],),
                        const SizedBox(height: ESizes.spaceBtwSections),

                        /// Attributes

                        EProductAttributes1(colour: data['RentProduct_colour'],price:data['price'],details: data['RentProduct_detail'],fabric: data['fabric'],status: data['availability'],id: widget.id),
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
                          data["RentProduct_detail"],
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const ESectionHeading(
                        //         title: 'Reviews(199)', showActionButton: false),
                        //     IconButton(icon: const Icon(
                        //         Iconsax.arrow_right_3, size: 18),
                        //         onPressed: () =>
                        //             Get.to(() => const ProductReviewsScreen())),
                        //   ],
                        // ),
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
      bottomNavigationBar: EBottomAddToCart1(id: widget.id, index: widget.index,),
    );
  }
}


