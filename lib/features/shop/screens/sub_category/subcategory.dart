import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../models/subcat_productlist_model.dart';

class ESubCategoryScreen extends StatefulWidget {
  const ESubCategoryScreen({super.key, required this.id});

  final String id;

  @override
  State<ESubCategoryScreen> createState() => _ESubCategoryScreenState();
}
class _ESubCategoryScreenState extends State<ESubCategoryScreen> {
  Map? data;
  var recdata;

  @override
  void initState() {
    super.initState();
  }

  Future<Map?> _fetchSubCategories() async {

    final ref = FirebaseDatabase.instance
        .ref()
        .child("Project/subcategory")
        .orderByChild("catid")
        .equalTo(widget.id);
    await ref.once().then((documentSnapshot) =>
    {
      recdata = documentSnapshot.snapshot.value
    });

    return recdata;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map?>(
      future: _fetchSubCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
        } else
        if (!snapshot.hasData || snapshot.data == null) {
        return const Center(child: Text(
          'Up Comming Data',
          style: TextStyle(fontSize: 10),
        ),);
        } else {
          return DefaultTabController(
            length: snapshot.data != null ? snapshot.data!.length : 0,
            child: Scaffold(
              appBar: EAppBar(
                title:
                Text('Sub Category', style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium),
                actions: const [
                  ECartCounterIcon(iconColor: Colors.black),
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      backgroundColor: EHelperFunctions.isDarkMode(context)
                          ? EColors.black
                          : EColors.white,
                      expandedHeight: 0,

                      ///Tabs
                      bottom: ETabBar(
                        tabs: [
                          for(var entry in snapshot.data!.entries)
                            Tab(child: Text(entry.value['subcat'])),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                     for (var entry in snapshot.data!.entries)
                        ESubCatProductList(productSubCat: entry.key.toString()),
                  ],
                ),
              ),
            ),
          );
        }
      }
    );
  }
}