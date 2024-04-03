import 'package:cubik_club/ui/common/widgets/components/search_input.dart';
import 'package:flutter/material.dart';

class SearchTopBar extends StatelessWidget {
  final double spacing;
  final List<Widget>? actions;
  const SearchTopBar({
    super.key,
    this.spacing = 25,
    this.actions,
  });

  List<Widget> _createChildren() {
    List<Widget> list = [
      const SearchInput(),
    ];

    if (actions != null) {
      list.add(SizedBox(width: spacing));
      list.addAll(actions!.map((widget) => widget));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 20,
        right: 20,
        top: kToolbarHeight,
      ),
      child: Row(
        children: _createChildren(),
      ),
    );
  }
}
