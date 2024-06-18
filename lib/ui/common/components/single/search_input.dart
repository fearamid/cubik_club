import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  const SearchInput({
    super.key,
    this.onSubmitted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          hintText: 'Поиск',
          hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
