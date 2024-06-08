import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:flutter/material.dart';

class GameTagsList extends StatelessWidget {
  final String gameName;
  final List<String> tags;

  const GameTagsList({
    super.key,
    required this.gameName,
    required this.tags,
  });

  List<Widget> _createChildren() {
    List<Widget> children = [
      Text(
        gameName,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 3),
    ];

    for (int i = 0; i < tags.length; i++) {
      children.add(
        Text(
          tags[i],
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _createChildren(),
      ),
    );
  }
}
