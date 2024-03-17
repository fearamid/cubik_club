import 'package:flutter/material.dart';

class WideButon extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  const WideButon({
    super.key,
    required this.title,
    required this.buttonStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: key,
      style: buttonStyle,
      onPressed: onPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
