import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class CollectionDisplayModeButton extends StatefulWidget {
  const CollectionDisplayModeButton({super.key});

  @override
  State<CollectionDisplayModeButton> createState() =>
      _CollectionDisplayModeButtonState();
}

class _CollectionDisplayModeButtonState
    extends State<CollectionDisplayModeButton> {
  static const IconData listIcon = Iconsax.row_horizontal_copy;
  static const IconData gridIcon = Iconsax.row_vertical_copy;

  late CollectionDisplayMode mode;
  late IconData icon;

  @override
  void initState() {
    super.initState();
    final viewMode =
        context.read<GamesCollectionScreenViewModel>().state.displayMode;

    mode = viewMode;
    icon = viewMode == CollectionDisplayMode.list ? gridIcon : listIcon;
  }

  void toggleMode() {
    if (mode == CollectionDisplayMode.list) {
      mode = CollectionDisplayMode.grid;
      icon = listIcon;
    } else {
      mode = CollectionDisplayMode.list;
      icon = gridIcon;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<GamesCollectionScreenViewModel>();

    return IconButton(
      icon: Icon(
        icon,
        size: 35,
        color: CCAppColors.secondary,
      ),
      onPressed: () {
        toggleMode();
        viewModel.onCollectionViewModeButtonPressed(mode);
      },
    );
  }
}
