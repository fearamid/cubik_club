import 'package:cubik_club/ui/common/components/single/custom_icon_button.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class RandomGameButton extends StatelessWidget {
  const RandomGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();
    return CustomIconButton(
      icon: Iconsax.colorfilter_copy,
      onPressed: () {
        model.onRandomGameButtonPressed(
          context,
          builder: (context) {
            // TODO: change
            return const Text('fsdfsdfsdff');
          },
        );
      },
    );
  }
}
