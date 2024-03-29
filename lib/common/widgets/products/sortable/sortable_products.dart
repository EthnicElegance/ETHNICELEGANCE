import 'package:ethnic_elegance/features/shop/models/product/productlist_model1.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/models/product/productlist_model.dart';
import '../../../../sharepreferences.dart';
import '../../../../utils/constants/sizes.dart';

class ESortableProducts extends StatefulWidget {
  const ESortableProducts({Key? key}) : super(key: key);

  @override
  State<ESortableProducts> createState() => _ESortableProductsState();
}

class _ESortableProductsState extends State<ESortableProducts> {
  String? userid;
  String _sortBy = 'All Products';
  bool? isRetailCustomer;

  @override
  void initState() {
    super.initState();
    getKey().then((String? value) {
      setState(() {
        userid = value;
      });
      checkUserType();
    });
  }

  Future<void> checkUserType() async {
    if (mounted) {
      final ref = FirebaseDatabase.instance
          .ref()
          .child("Project/UserRegister/$userid/UserType");
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
    return Column(
      children: [
        ///Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
            setState(() {
              _sortBy = value.toString();
            });
          },
          items: [
            'All Products',
            'Higher Price',
            'Lower Price',
          ].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        ),
        const SizedBox(height: ESizes.spaceBtwSections),
        /// Products
        isRetailCustomer == true
            ? EProductList1(sortBy: _sortBy,)
            : EProductList(sortBy: _sortBy,)
      ],
    );
  }
}
