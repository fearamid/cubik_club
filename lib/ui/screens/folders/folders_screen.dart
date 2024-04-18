import 'package:flutter/material.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Архив',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Column(),
      ),
    );
  }
}
