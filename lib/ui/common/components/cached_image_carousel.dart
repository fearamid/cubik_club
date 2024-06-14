import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
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

  final errorWidget = const Icon(Iconsax.aave_aave_copy);

  @override
  Widget build(BuildContext context) {
    List<String> imagesLinksList = [];

    if (Uri.tryParse(widget.coverLink)?.isAbsolute ?? false) {
      imagesLinksList.add(widget.coverLink);
    }
    if (widget.imagesLinks != null) {
      for (var link in widget.imagesLinks!) {
        if (Uri.tryParse(link)?.isAbsolute ?? false) {
          imagesLinksList.add(link);
        }
      }
    }

    List<CachedNetworkImage> imagesWidgets = List.generate(
      imagesLinksList.length,
      (index) => CachedNetworkImage(
        imageUrl: imagesLinksList[index],
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => errorWidget,
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
              children: imagesWidgets.isNotEmpty
                  ? imagesWidgets
                  : [Center(child: errorWidget)],
            ),
          ),
        ),
        if (imagesLinksList.length > 1)
          SizedBox(
            height: widget.spacing,
          ),
        if (imagesLinksList.length > 1)
          SmoothPageIndicator(
            effect: WormEffect(
              dotColor: CCAppColors.lightHighlightBackground,
              activeDotColor: CCAppColors.primary,
              dotHeight: widget.dotSize,
              dotWidth: widget.dotSize,
              spacing: widget.dotsSpacing,
            ),
            controller: controller,
            count: imagesLinksList.length,
          )
      ],
    );
  }
}
