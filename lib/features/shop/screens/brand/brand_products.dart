import 'package:ethnic_elegance/common/widgets/appbar/appbar.dart';
import 'package:ethnic_elegance/common/widgets/brands/brand_card.dart';
import 'package:ethnic_elegance/common/widgets/products/sortable/sortable_products.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget{
  const BrandProducts({super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EAppBar(title: Text('Nike'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              EBrandCard(showBorder: true),
              SizedBox(height: ESizes.spaceBtwSections),

              ESortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}