import 'package:cubik_club/utils/formatters/password_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PasswordTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool obscureText;
  final bool obscureButton;
  final String? label;
  const PasswordTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.obscureText = true,
    this.obscureButton = true,
    this.label,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    isPasswordVisible = !widget.obscureText;
    super.initState();
  }

  Widget? suffixButton() {
    if (!widget.obscureButton) return null;

    return IconButton(
      icon: Icon(isPasswordVisible ? Iconsax.eye_copy : Iconsax.eye_slash_copy),
      onPressed: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: !isPasswordVisible,
      inputFormatters: [
        PasswordInputFormatter(),
      ],
      decoration: InputDecoration(
        labelText: widget.label ?? 'Пароль',
        suffixIcon: suffixButton(),
      ),
    );
  }
}
