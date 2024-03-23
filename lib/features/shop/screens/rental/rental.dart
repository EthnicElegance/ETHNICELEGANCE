import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/products/cart/rent_cart_menu_icon.dart';
import 'package:ethnic_elegance/features/shop/models/rentproduct_list_model.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../navigation_menu1.dart';

class RentalScreen extends StatefulWidget {
  const RentalScreen({
    super.key,
  });

  @override
  State<RentalScreen> createState() => _RentalScreenState();
}

class _RentalScreenState extends State<RentalScreen> {
  Map? data;
  var recdata;
  bool catTap = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Map?> _fetchSubCategories1() async {
    final ref = FirebaseDatabase.instance
        .ref()
        .child("Project/category")
        .orderByChild('gender')
        .equalTo('Women');
    await ref.once().then(
        (documentSnapshot) => {recdata = documentSnapshot.snapshot.value});

    return recdata;
  }
  Future<Map?> _fetchSubCategories() async {
    final ref = FirebaseDatabase.instance.ref().child("Project/category").orderByChild('gender').equalTo('Men');
    await ref.once().then(
        (documentSnapshot) => {recdata = documentSnapshot.snapshot.value});

    return recdata;
  }

  @override
  Widget build(BuildContext context) {
    if (catTap == true) {
      return FutureBuilder<Map?>(
          future: _fetchSubCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'Up Coming Data',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: DefaultTabController(
                  length: snapshot.data != null ? snapshot.data!.length : 0,
                  child: Scaffold(
                    appBar: EAppBar(
                      title: Text('Rent',
                          style: Theme.of(context).textTheme.headlineMedium),
                      actions: const [
                        ERentCartCounterIcon(iconColor: Colors.black),
                      ],
                    ),

                    bottomNavigationBar: const NavigationMenu1(),
                    body: NestedScrollView(
                      //physics: const NeverScrollableScrollPhysics(),
                      headerSliverBuilder: (_, innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: true,
                            floating: true,
                            backgroundColor: EHelperFunctions.isDarkMode(context)
                                ? EColors.black
                                : EColors.white,
                            expandedHeight: 180,

                            flexibleSpace: Padding(
                              padding: const EdgeInsets.all(ESizes.defaultSpace),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [

                                  ///Brand Grid

                                  GridView.builder(
                                    itemCount: 2,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: ESizes.gridViewSpacing,
                                      crossAxisSpacing: ESizes.gridViewSpacing,
                                      mainAxisExtent: 100,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == 0) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              catTap = false;
                                            });
                                          },
                                          child: ERoundedContainer(
                                            padding: const EdgeInsets.all(0),
                                            showBorder: true,
                                            backgroundColor: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Center(
                                                    child: Stack(
                                                      children: <Widget>[
                                                        // ClipRRect to apply rounded corners to the image
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          // Adjust the radius as needed
                                                          child: Image.asset(
                                                            'assets/images/rent_images/rent_women.jpg',
                                                            width: 200,
                                                            height: 300,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 50,
                                                          left: 55,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: const Text(
                                                              'Women',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              catTap = true;
                                            });
                                          },
                                          child: ERoundedContainer(
                                            padding: const EdgeInsets.all(0),
                                            showBorder: true,
                                            backgroundColor: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Center(
                                                    child: Stack(
                                                      children: <Widget>[
                                                        // ClipRRect to apply rounded corners to the image
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          // Adjust the radius as needed
                                                          child: Image.asset(
                                                            'assets/images/rent_images/rent_men1.jpg',
                                                            width: 200,
                                                            height: 300,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 50,
                                                          left: 55,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: const Text(
                                                              'Men',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  //const ECategoryList(limitedCategory: true,categoryCount: 8,),
                                ],
                              ),
                            ),

                            //Tabs
                            bottom: ETabBar(
                              tabs: [
                                for (var entry in snapshot.data!.entries)
                                  Tab(child: Text(entry.value['name'])),
                              ],
                            ),
                          ),
                        ];
                      },
                      //body: Container(),
                      body: TabBarView(
                        children: [
                          for (var entry in snapshot.data!.entries)
                            ERentProductList(
                                productSubCat: entry.key.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          });
    } else
    {
      return FutureBuilder<Map?>(
          future: _fetchSubCategories1(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'Up Coming Data',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: DefaultTabController(
                  length: snapshot.data != null ? snapshot.data!.length : 0,
                  child: Scaffold(
                    appBar: EAppBar(
                      title: Text('Rent',
                          style: Theme.of(context).textTheme.headlineMedium),
                      actions: const [
                        ERentCartCounterIcon(iconColor: Colors.black),
                      ],
                    ),
                    bottomNavigationBar: const NavigationMenu1(),
                    body: NestedScrollView(
                      //physics: const NeverScrollableScrollPhysics(),
                      headerSliverBuilder: (_, innerBoxIsScrolled) {
                        return [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: true,
                            floating: true,
                            backgroundColor: EHelperFunctions.isDarkMode(context)
                                ? EColors.black
                                : EColors.white,
                            expandedHeight: 180,
                
                            flexibleSpace: Padding(
                              padding: const EdgeInsets.all(ESizes.defaultSpace),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                
                                  ///Brand Grid
                
                                  GridView.builder(
                                    itemCount: 2,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: ESizes.gridViewSpacing,
                                      crossAxisSpacing: ESizes.gridViewSpacing,
                                      mainAxisExtent: 100,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == 0) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              catTap = false;
                                            });
                                          },
                                          child: ERoundedContainer(
                                            padding: const EdgeInsets.all(0),
                                            showBorder: true,
                                            backgroundColor: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Center(
                                                    child: Stack(
                                                      children: <Widget>[
                                                        // ClipRRect to apply rounded corners to the image
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          // Adjust the radius as needed
                                                          child: Image.asset(
                                                            'assets/images/rent_images/rent_women.jpg',
                                                            width: 200,
                                                            height: 300,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 50,
                                                          left: 55,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: const Text(
                                                              'Women',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              catTap = true;
                                            });
                                          },
                                          child: ERoundedContainer(
                                            padding: const EdgeInsets.all(0),
                                            showBorder: true,
                                            backgroundColor: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Center(
                                                    child: Stack(
                                                      children: <Widget>[
                                                        // ClipRRect to apply rounded corners to the image
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          // Adjust the radius as needed
                                                          child: Image.asset(
                                                            'assets/images/rent_images/rent_men1.jpg',
                                                            width: 200,
                                                            height: 300,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 50,
                                                          left: 55,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: const Text(
                                                              'Men',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  //const ECategoryList(limitedCategory: true,categoryCount: 8,),
                                ],
                              ),
                            ),
                
                            //Tabs
                            bottom: ETabBar(
                              tabs: [
                                for (var entry in snapshot.data!.entries)
                                  Tab(child: Text(entry.value['name'])),
                              ],
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: [
                          for (var entry in snapshot.data!.entries)
                            ERentProductList(
                                productSubCat: entry.key.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          });
    }
  }
}
