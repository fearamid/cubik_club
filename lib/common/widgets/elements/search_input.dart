import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Поиск',
            hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
      ),
    );
  }
}
