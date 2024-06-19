import 'package:cubik_club/ui/common/components/single/search_input.dart';
import 'package:flutter/material.dart';

class SearchTopBar extends StatelessWidget {
  final TextEditingController? searchController;
  final ValueChanged<String>? onSubmitted;
  final double spacing;
  final List<Widget>? actions;

  const SearchTopBar({
    super.key,
    this.spacing = 25,
    this.actions,
    this.searchController,
    this.onSubmitted,
  });

  List<Widget> _createChildren() {
    List<Widget> list = [
      SearchInput(
        onSubmitted: onSubmitted,
        controller: searchController,
      ),
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
        top: 25,
      ),
      child: Row(
        children: _createChildren(),
      ),
    );
  }
}
