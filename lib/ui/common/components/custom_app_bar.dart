import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final double height;
  final bool popButton;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    this.leading,
    this.actions,
    this.height = kToolbarHeight,
    this.popButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: height,
      snap: true,
      floating: true,
      leading: popButton
          ? leading ??
              IconButton(
                icon: const Icon(Iconsax.arrow_left_2_copy),
                iconSize: 35,
                color: CCAppColors.secondary,
                onPressed: () => Navigator.of(context).pop(),
              )
          : null,
      actions: actions,
      backgroundColor: CCAppColors.lightBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
