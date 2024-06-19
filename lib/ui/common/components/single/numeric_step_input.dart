import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final int step;

  final ValueChanged<int> onChanged;

  const NumericStepButton({
    super.key,
    this.minValue = 0,
    this.maxValue = 10,
    required this.onChanged,
    this.value = 0,
    this.step = 1,
  });

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  late int counter;
  @override
  void initState() {
    super.initState();
    if (widget.value < widget.minValue || widget.value > widget.maxValue) {
      counter = widget.minValue;
    } else {
      counter = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 15,
      children: [
        CustomIconButton(
          icon: Iconsax.minus_copy,
          color: CCAppColors.lightHighlightBackground,
          onPressed: () {
            if (counter == widget.minValue) return;
            if (counter > widget.minValue) {
              counter -= widget.step;
              if (counter < widget.minValue) {
                counter = widget.minValue;
              }
            }
            widget.onChanged(counter);
            setState(() {});
          },
        ),
        Text(
          '$counter',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
          ),
        ),
        CustomIconButton(
          icon: Iconsax.add_copy,
          color: CCAppColors.lightHighlightBackground,
          onPressed: () {
            if (counter == widget.maxValue) return;
            if (counter < widget.maxValue) {
              counter += widget.step;
              if (counter > widget.maxValue) {
                counter = widget.maxValue;
              }
            }
            widget.onChanged(counter);
            setState(() {});
          },
        ),
      ],
    );
  }
}
