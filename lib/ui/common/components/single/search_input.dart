import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String>? onSubmitted;
  const SearchInput({
    super.key,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
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
