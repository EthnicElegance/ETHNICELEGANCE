import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/icons/brand_title_text_with_verified_iconn.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../sharepreferences.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class RentOrderDetailERentCartItem extends StatefulWidget {
  const RentOrderDetailERentCartItem({super.key, required this.id, this.index, required this.orderId});

  final String id;
  final index;
  final String orderId;


  @override
  State<RentOrderDetailERentCartItem> createState() => _RentOrderDetailERentCartItemState();
}

class _RentOrderDetailERentCartItemState extends State<RentOrderDetailERentCartItem> {
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
    dbRef = FirebaseDatabase.instance.ref().child('Project/RentOrderDetail');
    dbRef.orderByChild('OrderId').equalTo(widget.orderId).onValue.listen((event) async {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      print("--------------------values-------------------");
      print(values);
      if (values != null) {
        String productId;
        values.forEach((key, value) async {
          productId = value["RentProductId"];
          wishList.add({
            'cartKey': key,
            'RentProductId': value['RentProductId'],
            'Size': value['Size'],
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
                      'Rent Cart1 is Empty',
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                }
                return Row(
                  children: [
                    //image
                    ERoundedImage(
                      isNetworkImage: true,
                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/RentProductImage%2F${data2['photo1']}?alt=media",
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
                                title: data2['RentProduct_name'],
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
                                text: data2['RentProduct_colour'],
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyLarge),
                            const WidgetSpan(child: SizedBox(width: ESizes.spaceBtwItems),),
                            TextSpan(
                                text: "Size ",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall),
                            TextSpan(
                                text: data1['Size'],
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
    FirebaseDatabase.instance.ref().child("Project/RentProduct").child(key);
    DatabaseEvent userDataEvent = await dbUserData.once();
    DataSnapshot userDataSnapshot = userDataEvent.snapshot;
    userData = userDataSnapshot.value as Map?;
    prodMap[index] = {
      "RentProduct_name": userData!["RentProduct_name"],
      "photo1": userData!["photo1"],
      "photo2": userData!["photo2"],
      "photo3": userData!["photo3"],
      "price": userData!["price"],
      "size": userData!["size"],
      "qty": userData!["qty"],
      "RentProduct_colour": userData!["RentProduct_colour"],
      "fabric": userData!["fabric"],
      "RentProduct_detail": userData!["RentProduct_detail"],
      "availability": userData!["availability"]
    };
    _streamController.add(wishList); // Update the stream with new data
  }
}