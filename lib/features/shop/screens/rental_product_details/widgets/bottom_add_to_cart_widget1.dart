import 'package:ethnic_elegance/features/shop/models/rent_cart/rent_cart_insert_model.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../models/rent_product/rentproduct_model.dart';
import '../../rent_cart/rent_cart.dart';

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

class EBottomAddToCart1 extends StatefulWidget {
  const EBottomAddToCart1({super.key, required this.id, required this.index});

  final String id;
  final index;

  @override
  State<EBottomAddToCart1> createState() => _EBottomAddToCart1State();
}

class _EBottomAddToCart1State extends State<EBottomAddToCart1> {
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

    final dbRef = FirebaseDatabase.instance.ref().child('Project/RentalCart');
    final dark = EHelperFunctions.isDarkMode(context);
    return StreamBuilder(
        stream:
            FirebaseDatabase.instance.ref().child('Project/RentProduct').onValue,
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
                    v["availability"]
                ));
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (controller.size.value != '') {
                        RentCartInsertModel cartObj = RentCartInsertModel(
                            widget.id,
                            controller.counter.value,
                            controller.size.value,
                            prodlist[widget.index].rprice,
                            "${double.parse(prodlist[widget.index].rprice) * 3}",
                            "${double.parse(prodlist[widget.index].rprice) * int.parse(controller.counter.value)}",
                            userid!);
                        dbRef.push().set(cartObj.toJson());
                        ELoaders.successSnackBar(
                            title: 'Added to the Rent Cart',
                            message: 'The Rentproduct has been added to the Cart');
                        Get.to(() => const RentCartScreen());
                      } else {
                        ELoaders.errorSnackBar(
                            title: 'Oh snap!', message: "Select Size");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 100),
                      backgroundColor: EColors.black,
                      side: const BorderSide(color: EColors.black),
                    ),
                    child: const Text('Book Now'),
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
