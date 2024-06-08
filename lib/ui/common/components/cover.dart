import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SlidableImages extends StatelessWidget {
  final String coverLink;
  final List<String>? imagesLinks;
  final bool dots;
  const SlidableImages({
    super.key,
    required this.coverLink,
    this.imagesLinks,
    this.dots = true,
  });

  @override
  Widget build(BuildContext context) {
    List<String> imagesStack = [coverLink];
    if (imagesLinks != null) {
      for (var link in imagesLinks!) {
        imagesStack.add(link);
      }
    }

    List<CachedNetworkImage> imagesWidgets = List.generate(
      imagesStack.length,
      (index) => CachedNetworkImage(
        imageUrl: imagesStack[index],
        fit: BoxFit.cover,
      ),
    );

    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: PageView(
          children: imagesWidgets,
        ),
      ),
    );
  }
}
