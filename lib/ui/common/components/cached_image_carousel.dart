import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CachedImageCarousel extends StatefulWidget {
  final String coverLink;
  final List<String>? imagesLinks;
  final bool dots;
  final double spacing;
  final double dotsSpacing;
  final double dotSize;
  final ValueChanged<int>? onImageChanged;
  const CachedImageCarousel({
    super.key,
    required this.coverLink,
    this.imagesLinks,
    this.dots = true,
    this.spacing = 10,
    this.dotsSpacing = 20,
    this.dotSize = 8,
    this.onImageChanged,
  });

  @override
  State<CachedImageCarousel> createState() => _CachedImageCarouselState();
}

class _CachedImageCarouselState extends State<CachedImageCarousel> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<String> imagesStack = [widget.coverLink];
    if (widget.imagesLinks != null) {
      for (var link in widget.imagesLinks!) {
        imagesStack.add(link);
      }
    }

    List<CachedNetworkImage> imagesWidgets = List.generate(
      imagesStack.length,
      (index) => CachedNetworkImage(
        imageUrl: imagesStack[index],
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Image.asset(CCImages.calico);
        },
      ),
    );

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: PageView(
              controller: controller,
              onPageChanged: widget.onImageChanged,
              children: imagesWidgets,
            ),
          ),
        ),
        if (imagesStack.length != 1)
          SizedBox(
            height: widget.spacing,
          ),
        if (imagesStack.length != 1)
          SmoothPageIndicator(
            effect: WormEffect(
              dotColor: CCAppColors.lightHighlightBackground,
              activeDotColor: CCAppColors.primary,
              dotHeight: widget.dotSize,
              dotWidth: widget.dotSize,
              spacing: widget.dotsSpacing,
            ),
            controller: controller,
            count: imagesStack.length,
          )
      ],
    );
  }
}
