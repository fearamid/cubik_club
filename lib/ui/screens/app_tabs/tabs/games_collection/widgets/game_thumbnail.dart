import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameThumbnail extends StatelessWidget {
  const GameThumbnail({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();

    return Section(
      paddingHorizontal: 15,
      paddingVertical: 15,
      onTap: () => model.onGameThumbnailPressed(context, game: game),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 1,
            child: Image(
              image: AssetImage(CCImages.gameOpt),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            game.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 10),
          // TagsList([
          //   tags.genres,
          //   tags.author,
          //   '${tags.duration} мин',
          //   '${tags.ageLimit}+'
          // ]),
        ],
      ),
    );
  }
}
