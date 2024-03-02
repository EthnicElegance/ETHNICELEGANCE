import 'package:ethnic_elegance/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ethnic_elegance/utils/constants/colors.dart';
import 'package:ethnic_elegance/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class EChoiceChip extends StatelessWidget {
  const EChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    // bool chk = false;
    // final PaController controller = Get.put(PaController());

    final isColor = EHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
          label: isColor ? const SizedBox() : Text(text),
          selected: selected,
          onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? EColors.white : null),
          avatar: isColor
              ? ECircularContainer(
                  width: 50,
                  height: 50,
                  backgroundColor: EHelperFunctions.getColor(text)!)
              : null,
          labelPadding: isColor ? const EdgeInsets.all(0) : null,
          //make icon in center
          padding: isColor ? const EdgeInsets.all(0) : null,
          shape: isColor ? const CircleBorder() : null,
          backgroundColor: isColor ? EHelperFunctions.getColor(text) : null,
        ),
    );
  }
}
