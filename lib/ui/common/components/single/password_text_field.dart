import 'package:cubik_club/utils/formatters/password_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PasswordTextField<Type> extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const PasswordTextField({
    super.key,
    this.onChanged,
    this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: !isPasswordVisible,
      inputFormatters: [PasswordInputFormatter()],
      decoration: InputDecoration(
        labelText: 'Пароль',
        suffixIcon: IconButton(
          icon: Icon(
              isPasswordVisible ? Iconsax.eye_copy : Iconsax.eye_slash_copy),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}
