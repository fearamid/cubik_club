import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DynamicRangeSlider extends StatefulWidget {
  final double min;
  final double max;
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;
  const DynamicRangeSlider({
    super.key,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.values,
  });

  @override
  State<DynamicRangeSlider> createState() => _DynamicRangeSliderState();
}

class _DynamicRangeSliderState extends State<DynamicRangeSlider> {
  late RangeValues values;

  @override
  void initState() {
    super.initState();
    values = widget.values;
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: CCAppColors.primary,
      inactiveColor: CCAppColors.lightSectionBackground,
      min: widget.min,
      max: widget.max,
      values: values,
      onChanged: (newRange) {
        setState(() {
          values = newRange;
        });
        widget.onChanged(newRange);
      },
    );
  }
}
