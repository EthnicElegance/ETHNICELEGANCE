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
import 'package:get/get.dart';

import 'bottom_add_to_cart_widget.dart';

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
  final CartController controller = Get.put(CartController());

  late List<String> size;
  late List<String> colors;
  String? selectedSize;
  String? selectedColor;

  @override
  void initState() {
    super.initState();
    selectedSize = null;
    selectedColor = null;
    size = [];
    colors = [];
    _fetchSubCategories();
  }

  Future<void> _fetchSubCategories() async {
    final ref = FirebaseDatabase.instance.ref().child("Project/product/${widget.id}");
    final documentSnapshot = await ref.once();
    final recdata = documentSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (recdata != null) {


    }

    if (recdata != null) {

      final sizeData = recdata['size'] as String?;
      final colorData = recdata['product_colour'] as String?;
      print(colorData);
      if (colorData != null) {
        colors = recdata.entries
            .where((entry) => entry.key == 'product_colour')
            .map((entry) => entry.value.toString())
            .toList();
      }
      print(colors);
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
                          Text(widget.fabric, style: Theme.of(context).textTheme.titleMedium),
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
              children: colors.map((item) {
                return EChoiceChip(
                  text: item,
                  selected: selectedColor == item,
                  onSelected: (value) {
                    setState(() {
                      selectedColor = value ? item : null;
                    });
                  },
                );
              }).toList(),
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
                      controller.size = RxString(item);
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
