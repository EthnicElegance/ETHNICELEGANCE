/*
import 'package:ethnic_elegance/common/widgets/chips/choice_chip.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_title_text.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class EProductAttributes extends StatefulWidget {
  const EProductAttributes(
      {super.key,
      required this.colour,
      required this.fabric,
      required this.details,
      required this.price,
      required this.id});

  final String colour, price, fabric, details, id;

  @override
  State<EProductAttributes> createState() => _EProductAttributesState();
}

class _EProductAttributesState extends State<EProductAttributes> {
  Map? data;
  var recdata;
  var recdata1;
  bool chk = false;
  // int _selectedValue = 0;
  int i = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<Map?> _fetchSubCategories() async {
    final ref =
        FirebaseDatabase.instance.ref().child("Project/product/${widget.id}");
    await ref.once().then(
        (documentSnapshot) => {recdata = documentSnapshot.snapshot.value});

    // print('---------------------------------recdata--------------------------');
    // print(recdata);
    // print(recdata['size']);
    final ref2 = FirebaseDatabase.instance
        .ref()
        .child("Project/size/${recdata['size']}");
    await ref2.once().then(
        (documentSnapshot) => {recdata1 = documentSnapshot.snapshot.value});
    // print(
    //     '---------------------------------recdata1--------------------------');
    // print(recdata1);

    return recdata1;
  }

  @override
  Widget build(BuildContext context) {
    List<String> size = [];

    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// Select Attribute Pricing & Description
        ERoundedContainer(
          padding: const EdgeInsets.all(ESizes.md),
          backgroundColor: dark ? EColors.darkerGrey : EColors.grey,
          child: Column(
            children: [
              ///Title, price and Stock Status
              Row(
                children: [
                  const ESectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: ESizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const EProductTitleText(
                              title: '  Price : ', smallSize: true),
                          const SizedBox(width: ESizes.spaceBtwItems),
                          /// Sale Price
                          EProductPriceText(
                            price: widget.price,
                          )
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const EProductTitleText(
                              title: 'Fabric : ', smallSize: true),
                          const SizedBox(width: ESizes.spaceBtwItems),
                          Text(widget.fabric,
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              EProductTitleText(
                title: widget.details,
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: ESizes.spaceBtwItems),

        /// Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ESectionHeading(
              title: 'Colors',
              showActionButton: false,
            ),
            const SizedBox(height: ESizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                EChoiceChip(
                    text: 'Green', selected: false, onSelected: (value) {}),
                EChoiceChip(
                    text: 'Blue', selected: true, onSelected: (value) {}),
                EChoiceChip(
                    text: 'Red', selected: false, onSelected: (value) {}),
              ],
            ),
          ],
        ),
        FutureBuilder(
          future: _fetchSubCategories(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              for (var entry in snapshot.data!.entries) {
                if (entry.value != '0') {
                  size.add(entry.key);
                }
              }
              // var boolList = snapshot.data!.entries
              //     .map((entry) => {entry.key: false})
              //     .toList();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text(
                    'Up Coming Data',
                    style: TextStyle(fontSize: 10),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ESectionHeading(
                      title: 'Size',
                      showActionButton: false,
                    ),
                    const SizedBox(height: ESizes.spaceBtwItems / 2),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (var entry in snapshot.data!.entries)
                          if (entry.value != '0')
                            EChoiceChip(
                                text: entry.key,
                                selected: false,
                                onSelected: (value) {}
                            )

                      ],
                    ),
                  ],
                );
              }
            }
            else {
              return const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                    strokeWidth: 1.5),
              );
            }
          }
        ),
      ],
    );
  }
}
*/

import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ethnic_elegance/common/widgets/chips/choice_chip.dart';
import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_price_text.dart';
import 'package:ethnic_elegance/common/widgets/texts/product_title_text.dart';
import 'package:ethnic_elegance/common/widgets/texts/section_heading.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/constants/sizes.dart';

class EProductAttributes extends StatefulWidget {
  const EProductAttributes({
    Key? key,
    required this.colour,
    required this.fabric,
    required this.details,
    required this.price,
    required this.id,
  }) : super(key: key);

  final String colour, price, fabric, details, id;

  @override
  State<EProductAttributes> createState() => _EProductAttributesState();
}

class _EProductAttributesState extends State<EProductAttributes> {
  late List<String> size;
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = null;
    size = [];
    _fetchSubCategories();
  }

  Future<void> _fetchSubCategories() async {
    final ref = FirebaseDatabase.instance.ref().child("Project/product/${widget.id}");
    final documentSnapshot = await ref.once();
    final recdata = documentSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (recdata != null) {
      final sizeData = recdata['size'] as String?;
      if (sizeData != null) {
        final ref2 = FirebaseDatabase.instance.ref().child("Project/size/$sizeData");
        final documentSnapshot2 = await ref2.once();
        final recdata1 = documentSnapshot2.snapshot.value as Map<dynamic, dynamic>?;

        if (recdata1 != null) {
          setState(() {
            size = recdata1.entries
                .where((entry) => entry.value != '0')
                .map((entry) => entry.key.toString())
                .toList();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ERoundedContainer(
          padding: const EdgeInsets.all(ESizes.md),
          backgroundColor: dark ? EColors.darkerGrey : EColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  const ESectionHeading(title: 'Variation', showActionButton: false),
                  const SizedBox(width: ESizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const EProductTitleText(title: '  Price : ', smallSize: true),
                          const SizedBox(width: ESizes.spaceBtwItems),
                          EProductPriceText(price: widget.price),
                        ],
                      ),
                      Row(
                        children: [
                          const EProductTitleText(title: 'Fabric : ', smallSize: true),
                          const SizedBox(width: ESizes.spaceBtwItems),
                          Text(widget.fabric, style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              EProductTitleText(
                title: widget.details,
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: ESizes.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ESectionHeading(title: 'Colors', showActionButton: false),
            const SizedBox(height: ESizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                EChoiceChip(text: 'Green', selected: false, onSelected: (value) {}),
                EChoiceChip(text: 'Blue', selected: true, onSelected: (value) {}),
                EChoiceChip(text: 'Red', selected: false, onSelected: (value) {}),
              ],
            ),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ESectionHeading(title: 'Size', showActionButton: false),
            const SizedBox(height: ESizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: size.map((item) {
                return EChoiceChip(
                  text: item,
                  selected: selectedSize == item,
                  onSelected: (value) {
                    setState(() {
                      selectedSize = value ? item : null;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
