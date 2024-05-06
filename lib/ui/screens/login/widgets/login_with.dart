import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginWithButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final double iconSize;
  final double padding;
  const LoginWithButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 45,
    this.padding = 7,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: key,
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(padding)),
      ),
      child: Icon(icon, size: iconSize),
    );
  }
}

class _LoginWithSeparator extends StatelessWidget {
  final Color textColor;
  final Color lineColor;
  final Color darkLineColor;
  final double lineThick;

  const _LoginWithSeparator({
    super.key,
    this.textColor = CCAppColors.secondary,
    this.lineColor = CCAppColors.lightHighlightBackground,
    this.darkLineColor = CCAppColors.darkHighlightBackground,
    this.lineThick = 1,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = CCHelperFunctions.isDarkMode(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: lineThick,
            color: isDarkMode ? darkLineColor : lineColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Войти с',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: lineThick,
            color: isDarkMode ? darkLineColor : lineColor,
          ),
        ),
      ],
    );
  }
}

class LoginWith extends StatelessWidget {
  final List<LoginWithButton> children;
  final bool isSeparatorEnabled;
  final double spacing;
  const LoginWith({
    super.key,
    required this.children,
    this.isSeparatorEnabled = true,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> body = (isSeparatorEnabled
        ? [
            const _LoginWithSeparator(),
            SizedBox(height: spacing),
          ]
        : []);
    body.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children.map((LoginWithButton item) => item).toList(),
      ),
    );
    return Column(children: body);
  }
}
