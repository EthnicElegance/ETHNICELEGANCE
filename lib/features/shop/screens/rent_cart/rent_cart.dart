import 'package:ethnic_elegance/common/widgets/products/cart/rent_add_remove_button.dart';
import 'package:ethnic_elegance/common/widgets/products/cart/rent_cart_item.dart';
import 'package:ethnic_elegance/features/shop/models/rent_cart/rent_cart_insert_model1.dart';
import 'package:ethnic_elegance/features/shop/screens/home/home.dart';
import 'package:ethnic_elegance/features/shop/screens/rent_order/rent_checkout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/sizes.dart';
import '../home/home1.dart';

class RentCartScreen extends StatefulWidget {
  const RentCartScreen({Key? key}) : super(key: key);

  @override
  State<RentCartScreen> createState() => _RentCartScreenState();
}

class _RentCartScreenState extends State<RentCartScreen> {
  String? userId;
  bool? isRetailCustomer;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
      checkUserType();
    });
  }

  Future<void> checkUserType() async {
    if (mounted) {
      final ref = FirebaseDatabase.instance
          .ref()
          .child("Project/UserRegister/$userId/UserType");
      final snapshot = await ref.once();

      if (snapshot.snapshot.value == "Retail Customer") {
        setState(() {
          isRetailCustomer = true;
        });
      } else {
        setState(() {
          isRetailCustomer = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref()
          .child('Project/RentalCart')
          .orderByChild('UserId')
          .equalTo(userId)
          .onValue,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.black),
              strokeWidth: 1.5,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return Scaffold(
            appBar: EAppBar(
              showBackArrow: true,
              title: Text(
                "Rental Cart",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: const Center(
              child: Text(
                'Rental Cart is Empty',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        } else {
          Map<dynamic, dynamic> cartData =
          snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          List<RentCartInsertModel1> cartList = [];

          cartData.forEach((key, value) {
            if (value != null) {
              cartList.add(RentCartInsertModel1(
                key.toString(),
                value["RentProductId"],
                value["CartQty"],
                value["Size"],
                value["Price"],
                value["Deposit"],
                value["TotalPrice"],
                value["UserId"],
              ));
            }
          });

          return Scaffold(
            appBar: EAppBar(
              showBackArrow: false,
              leadingIcon: Iconsax.arrow_left,
              leadingOnPressed: () => isRetailCustomer == true ? Get.offAll(() => const HomeScreen1()) : Get.offAll(() => const HomeScreen()),
              title: Text(
                "Rental Cart",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: cartList.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: ESizes.spaceBtwSections),
                itemBuilder: (_, index) => Column(
                  children: [
                    ERentCartItem(id: cartList[index].rentProductId, index: index),
                    const SizedBox(height: ESizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            ERentProductQuantityWithAddRemoveButton(
                              cartQty: cartList[index].cartQTY,
                              cartId: cartList[index].id, price: cartList[index].price,
                            ),
                          ],
                        ),
                        EProductPriceText(
                          price: "${
                            int.parse(cartList[index].price) *
                                int.parse(cartList[index].cartQTY)
                          }",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const RentCheckOutScreen());
                },
                child: const Text("Book Now"), // You can dynamically set total price here
              ),
            ),
          );
        }
      },
    );
  }
}
