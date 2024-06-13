import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
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
      onTap: () => model.onGameThumbnailPressed(context, game),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Cover(game),
          const SizedBox(height: 15),
          Text(
            game.name,
            style: const TextStyle(height: 1, overflow: TextOverflow.ellipsis),
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

class _Cover extends StatelessWidget {
  final Game game;
  const _Cover(this.game);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: AspectRatio(
        aspectRatio: 1,
        child: Uri.tryParse(game.coverLink)?.hasAbsolutePath ?? false
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: game.coverLink,
                errorWidget: (_, __, ___) => const Icon(Iconsax.additem),
              )
            : const Center(
                child: Icon(
                  Iconsax.game_copy,
                  size: 30,
                ),
              ),
      ),
    );
  }
}
