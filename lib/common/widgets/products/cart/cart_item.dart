import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/brand_title_text_with_verified_iconn.dart';
import '../../images/rounded_image.dart';
import '../../texts/product_title_text.dart';

class ECartItem extends StatefulWidget {
  const ECartItem({super.key, required this.id, this.index});

  final String id;
  final index;


  @override
  State<ECartItem> createState() => _ECartItemState();
}

class _ECartItemState extends State<ECartItem> {
  String? userid;
  late Query dbRef;
  late Query dbRefWish;
  late StreamController<List<Map>> _streamController;
  Map<dynamic, dynamic>? userData;
  Map<int, Map> prodMap = {};
  late Map data1;
  late Map data2;
  late List<Map> productList = [];

  List<Map> wishList = [];

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
    });
  }

  Future<void> getCartData() async {
    _streamController = StreamController<List<Map>>();
    wishList.clear();
    prodMap.clear();
    dbRef = FirebaseDatabase.instance.ref().child('Project/cart');
    dbRef.orderByChild("userId").equalTo(userid).onValue.listen((event) async {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        String productId;
        values.forEach((key, value) async {
          productId = value["productId"];
          wishList.add({
            'cartKey': key,
            'productId': value['productId'],
            'size': value['size'],
            "userId": value["userId"],
          });
          await fetchProductData(productId, wishList.length - 1);
        });
      }
      _streamController.add(wishList);
    });
  }


  @override
  Widget build(BuildContext context) {
    getCartData();
    return StreamBuilder(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.black),
                strokeWidth: 1.5,
              ),
            );
          } else {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              List<Map> cartList = snapshot.data;

              data1 = cartList[widget.index];
              data2 = prodMap[widget.index] ?? {};
              // Map<dynamic, dynamic> map = snapshot.data;
              //
              if (data1.isNotEmpty && data2.isNotEmpty) {
                if (cartList.isEmpty) {
                  return const Center(
                    child: Text(
                      'Cart is Empty',
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                }
                return Row(
                  children: [
                    //image
                    ERoundedImage(
                      isNetworkImage: true,
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${data2['photo1']}?alt=media",
                      width: 70,
                      height: 100,
                      fit: BoxFit.fill,
                      padding: const EdgeInsets.all(0),
                      backgroundColor: EHelperFunctions.isDarkMode(context)
                          ? EColors.darkerGrey
                          : EColors.light,
                    ),
                    const SizedBox(width: ESizes.spaceBtwItems),

                    //title , price & size
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EBrandTitleWithVerifiedIcon(
                              title: data2['availability']),
                          Flexible(
                              child: EProductTitleText(
                                title: data2['product_name'],
                                maxLines: 1,
                              )),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "Color ",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall),
                            TextSpan(
                                text: data2['product_colour'],
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge),
                            TextSpan(
                                text: "Size ",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall),
                            TextSpan(
                                text: data1['size'],
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge),
                          ]))
                        ],
                      ),
                    )
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
            } else {
              return const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 1.5),
              );
            }
          }
        });
  }
  Future<void> fetchProductData(String key, int index) async {
    DatabaseReference dbUserData =
    FirebaseDatabase.instance.ref().child("Project/product").child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    prodMap[index] = {
      "product_name": userData!["product_name"],
      "photo1": userData!["photo1"],
      "photo2": userData!["photo2"],
      "photo3": userData!["photo3"],
      "retailer_price": userData!["retailer_price"],
      "size": userData!["size"],
      "qty": userData!["qty"],
      "product_colour": userData!["product_colour"],
      "fabric": userData!["fabric"],
      "detail": userData!["detail"],
      "availability": userData!["availability"]
    };
    _streamController.add(wishList); // Update the stream with new data
  }
}