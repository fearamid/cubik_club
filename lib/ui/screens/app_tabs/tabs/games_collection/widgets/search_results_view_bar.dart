import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/collection_display_mode_button.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/dropdown_filters.dart';
import 'package:flutter/material.dart';

class SearchResultsViewBar extends StatelessWidget {
  const SearchResultsViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Section(
      paddingVertical: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownFilters(),
          CollectionDisplayModeButton(),
        ],
      ),
    );
  }
}
