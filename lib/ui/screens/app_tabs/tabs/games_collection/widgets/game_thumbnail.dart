import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GameThumbnail extends StatelessWidget {
  final void Function(Game game)? onTap;
  final int nameMaxLines;
  final double fontSize;

  const GameThumbnail({
    super.key,
    required this.game,
    this.onTap,
    this.nameMaxLines = 1,
    this.fontSize = 18,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Section(
      paddingHorizontal: 15,
      paddingVertical: 15,
      onTap: () {
        if (onTap != null) {
          onTap!(game);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Cover(game),
          const SizedBox(height: 15),
          Text(
            game.name,
            style: TextStyle(
              height: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: fontSize,
            ),
            maxLines: nameMaxLines,
          ),
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
