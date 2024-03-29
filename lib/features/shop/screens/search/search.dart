import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/styles/shadows.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/wishlist_service.dart';
import '../../models/wishlist/wishlist_item.dart';
import '../product_details/product_detail1.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  bool? isRetailCustomer;
  String? userId;
  List<Map> wishlistList = [];
  Map<int, Map> userMap = {};

  var dbRef;
  TextEditingController searchController = TextEditingController();
  late StreamController<List<Map>> _streamController;
  String searchValue = '';
  Timer? _debounce;
  late AnimationController _animationController;
  late Animation<double> _animation;

  late String searchQuery;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userId = value;
      });
      checkUserType();
    });
    _streamController = StreamController<List<Map>>();
    dbRef = FirebaseDatabase.instance.ref().child('Project/product');
    _updateList('');
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      });
    _animationController.forward();
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

  void _updateList(String query) {
    // Cancel the previous debounce timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Create a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Convert the query to lowercase for case-insensitive search
      String lowercaseQuery = query.toLowerCase();

      dbRef.orderByChild("product_name").onValue.listen((event) {
        Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
        List<Map> products = [];
        if (values != null) {
          values.forEach((key, value) {
            if (value['customer_price'] != "0") {
              // Check if the value has a 'Photo' field and it is not empty
              if (value['photo1'] != null &&
                  value['photo1'].toString().isNotEmpty) {
                // Convert the productName to lowercase for case-insensitive comparison
                String productNameLowerCase =
                    (value['product_name'] as String?)?.toLowerCase() ?? '';

                // Check if the lowercase version of productName contains the lowercase query
                if (productNameLowerCase.contains(lowercaseQuery)) {
                  products.add({
                    'product_id': key,
                    'product_name': value['product_name'],
                    'price': value['customer_price'],
                    'availability': value['availability'],
                    'photo1': value['photo1'],
                  });
                }
              } else {
                products.add({
                  'product_id': key,
                  'product_name': value['product_name'],
                  'price': value['customer_price'],
                  'availability': value['availability'],
                  'photo1': 'noImage',
                  // Placeholder value
                });
              }
            } else if (value['retailer_price'] != "0") {
              // Check if the value has a 'Photo' field and it is not empty
              if (value['photo1'] != null &&
                  value['photo1'].toString().isNotEmpty) {
                // Convert the productName to lowercase for case-insensitive comparison
                String productNameLowerCase =
                    (value['product_name'] as String?)?.toLowerCase() ?? '';

                // Check if the lowercase version of productName contains the lowercase query
                if (productNameLowerCase.contains(lowercaseQuery)) {
                  products.add({
                    'product_id': key,
                    'product_name': value['product_name'],
                    'price': value['retailer_price'],
                    'availability': value['availability'],
                    'photo1': value['photo1'],
                  });
                }
              } else {
                products.add({
                  'product_id': key,
                  'product_name': value['product_name'],
                  'price': value['retailer_price'],
                  'availability': value['availability'],
                  'photo1': 'noImage',
                  // Placeholder value
                });
              }
            }
          });
        }
        _streamController.add(products);
        _animationController.stop();
      });
    });
  }

  Future<void> getWishlistData() async {

    wishlistList.clear();
    userMap.clear();
    dbRef = FirebaseDatabase.instance.ref().child('Project/wishlist');
    dbRef
        .orderByChild("userId")
        .equalTo(userId)
        .onValue
        .listen((event) async {
      Map<dynamic, dynamic>? values = event.snapshot.value as Map?;
      if (values != null) {
        values.forEach((key, value) async {
          wishlistList.add({
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

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Search Results'),
        title: Container(
          width: EDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(ESizes.sm),
          decoration: BoxDecoration(
            color: dark ? EColors.dark : EColors.white,
            borderRadius: BorderRadius.circular(ESizes.cardRadiusLg),
            border: Border.all(color: EColors.grey),
          ),
          child: CupertinoSearchTextField(
            controller: searchController,
            autofocus: true,
            onChanged: (String value) {
              setState(() {
                searchValue = value;
                _updateList(searchValue);
              });
            },
            decoration: const BoxDecoration(),
            autocorrect: true,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              StreamBuilder(
                  stream: _streamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CustomPaint(
                          painter: MyCustomPainter(_animation.value),
                          child: Container(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<Map>? products = snapshot.data;
                      if (products != null && products.isNotEmpty) {
                        return Padding(
                              padding: EdgeInsets.zero,
                              child: SizedBox(
                                width: 400,
                                child: GridView.builder(
                                  itemCount: products.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: ESizes.gridViewSpacing,
                                    crossAxisSpacing: ESizes.gridViewSpacing,
                                    mainAxisExtent: 280,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    Map data1 = products[index];
                                    // final product = products[index];
                                    if (data1['customer_price'] != '0') {
                                      String productId = data1['product_id'];
                                      final found = wishlistList
                                          .map((item) => item['productId'])
                                          .toList()
                                          .contains(productId);
                                      var icon =
                                          found ? Iconsax.heart5 : Iconsax.heart;

                                      return GestureDetector(
                                        onTap: () => Get.to(() =>
                                            ProductDetailScreen1(
                                                id: data1['product_id'],
                                                index: index)),
                                        child: Container(
                                          width: 180,
                                          padding: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              EShadowStyle.verticalProductShadow
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                ESizes.productImageRadius),
                                            color: dark
                                                ? EColors.darkerGrey
                                                : EColors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              ///Thumbnail
                                              ERoundedContainer(
                                                height: 180,
                                                padding:
                                                    const EdgeInsets.only(top: 5.0),
                                                backgroundColor: dark
                                                    ? EColors.dark
                                                    : EColors.light,
                                                child: Stack(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  ESizes.md),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  ESizes.md),
                                                          child: Image(
                                                            image: NetworkImage(
                                                              "https://firebasestorage.googleapis.com/v0/b/ethnicelegance-71357.appspot.com/o/ProductImage%2F${data1['photo1']}?alt=media",
                                                            ),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    /// Favourite Icon Button
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: ECircularIcon(
                                                        icon: icon,
                                                        color: Colors.red,
                                                        onPressed: () async {
                                                          if (icon == Iconsax.heart) {
                                                            setState(() {
                                                              icon = Iconsax.heart5;
                                                            });
                                                            await WishlistService()
                                                                .addToWishlist(WishlistItem(
                                                                productId:
                                                                data1['product_id'],
                                                                userId: userId!));
                                                          } else if (icon ==
                                                              Iconsax.heart5) {
                                                            setState(() {
                                                              icon = Iconsax.heart;
                                                            });
                                                            await WishlistService()
                                                                .removeFromWishlist(wishlistList
                                                                .firstWhere((item) =>
                                                            item[
                                                            'productId'] ==
                                                                productId)[
                                                            'wishlistkey']);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(
                                                  height: ESizes.spaceBtwItems / 2),

                                              ///details
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: ESizes.sm),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    EProductTitleText(
                                                      title: data1['product_name'],
                                                      smallSize: true,
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            ESizes.spaceBtwItems / 2),
                                                    Row(
                                                      children: [
                                                        Text(data1['availability'],
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                            style: Theme
                                                                .of(context)
                                                                .textTheme
                                                                .labelMedium),
                                                        const SizedBox(height: ESizes.xs),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              ///Price Row
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [

                                                  ///Price
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: ESizes.sm),
                                                    child: EProductPriceText(
                                                        price: data1['price']),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      // If product price is 0, return an empty container or null widget
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            );
                      } else {
                        return const Center(child: Text('No products found'));
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _debounce?.cancel(); // Cancel the debounce timer to prevent memory leaks
    _animationController.dispose();
    super.dispose();
  }
}

class MyCustomPainter extends CustomPainter {
  final double animationValue;

  MyCustomPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (int value = 3; value >= 0; value--) {
      circle(canvas, Rect.fromLTRB(0, 0, size.width, size.height),
          value + animationValue);
    }
  }

  void circle(Canvas canvas, Rect rect, double value) {
    Paint paint = Paint()
      ..color = Colors.blueGrey.withOpacity((1 - (value / 4)).clamp(.0, 1));

    canvas.drawCircle(rect.center,
        sqrt((rect.width * .5 * rect.width * .5) * value / 4), paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return true;
  }
}
