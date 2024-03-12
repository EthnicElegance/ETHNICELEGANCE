import 'package:ethnic_elegance/common/widgets/icons/circular_icon.dart';
import 'package:ethnic_elegance/features/shop/models/cart_insert_model.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../models/product_model.dart';
import '../../cart/cart.dart';

class CartController extends GetxController {
  final RxString counter = RxString('1');
  late RxString size = RxString('');

  void increment() {
    counter.value = (int.parse(counter.value) + 1).toString();
  }

  void decrement() {
    counter.value = (int.parse(counter.value) - 1).toString();
  }
}

class EBottomAddToCart extends StatefulWidget {
  const EBottomAddToCart({super.key, required this.id, required this.index});

  final String id;
  final index;

  @override
  State<EBottomAddToCart> createState() => _EBottomAddToCartState();
}

class _EBottomAddToCartState extends State<EBottomAddToCart> {
  final CartController controller = Get.put(CartController());
  String? userid;

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
    // var count = 0;
    final dbRef = FirebaseDatabase.instance.ref().child('Project/cart');
    final dark = EHelperFunctions.isDarkMode(context);
    return StreamBuilder(
        stream:
            FirebaseDatabase.instance.ref().child('Project/product').onValue,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

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

            map.forEach((dynamic key, dynamic v) {
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
            return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: ESizes.defaultSpace,
                  vertical: ESizes.defaultSpace / 2),
              decoration: BoxDecoration(
                color: dark ? EColors.darkerGrey : EColors.light,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(ESizes.cardRadiusLg),
                  topRight: Radius.circular(ESizes.cardRadiusLg),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ECircularIcon(
                        icon: Iconsax.minus,
                        backgroundColor: EColors.darkerGrey,
                        width: 40,
                        height: 40,
                        color: EColors.white,
                        onPressed: () {
                          if (controller.counter.value != '0' && controller.counter.value != '1') {
                            controller.decrement();
                          }
                        },
                      ),
                      const SizedBox(width: ESizes.spaceBtwItems),
                      Obx(
                        () => Text(controller.counter.value,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                      const SizedBox(width: ESizes.spaceBtwItems),
                      ECircularIcon(
                        icon: Iconsax.add,
                        backgroundColor: EColors.black,
                        width: 40,
                        height: 40,
                        color: EColors.white,
                        onPressed: controller.increment,
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.size.value != '') {
                        CartInsertModel cartObj = CartInsertModel(
                            widget.id,
                            controller.counter.value,
                            controller.size.value,
                            prodlist[widget.index].price,
                            userid!);
                        dbRef.push().set(cartObj.toJson());
                        ELoaders.successSnackBar(
                            title: 'Added to the Cart',
                            message: 'The product has been added to the Cart');
                        Get.to(() => const CartScreen());
                      } else {
                        ELoaders.errorSnackBar(
                            title: 'Oh snap!', message: "Select Size");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(ESizes.md),
                      backgroundColor: EColors.black,
                      side: const BorderSide(color: EColors.black),
                    ),
                    child: const Text('Add To Cart'),
                  )
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
        });
  }
}
