import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownFilters extends StatelessWidget {
  const DropdownFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();

    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: 0,
        iconDisabledColor: CCAppColors.secondary,
        iconEnabledColor: CCAppColors.secondary,
        items: const [
          DropdownMenuItem(
            value: 0,
            child: Text(
              'Популярное',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: CCAppColors.secondary,
              ),
            ),
          ),
        ],
        onChanged: (index) => model.onDropDownFiltersChanged(index),
      ),
    );
  }
}
