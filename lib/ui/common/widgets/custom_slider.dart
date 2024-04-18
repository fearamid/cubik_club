import 'package:carousel_slider/carousel_slider.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSlider extends StatefulWidget {
  final int count;
  final double spacing;
  final ExtendedIndexedWidgetBuilder itemBuilder;
  final bool autoPlay;
  final double height;
  final double dotSize;
  final double dotSpacing;
  final Function(int) onPageChanged;

  const CustomSlider({
    super.key,
    required this.count,
    required this.itemBuilder,
    required this.height,
    required this.onPageChanged,
    this.spacing = 10,
    this.autoPlay = true,
    this.dotSize = 8,
    this.dotSpacing = 15,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  var pageController = PageController();
  int currentItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool autoPlay = widget.autoPlay;
    if (widget.count <= 1) {
      autoPlay = false;
    }
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: CarouselController(),
          itemCount: widget.count,
          options: CarouselOptions(
            autoPlay: autoPlay,
            height: widget.height,
            viewportFraction: 1,
            onPageChanged: (int index, _) {
              setState(() {
                currentItemIndex = index;
                pageController = PageController(initialPage: currentItemIndex);
                widget.onPageChanged(index);
              });
            },
          ),
          itemBuilder: widget.itemBuilder,
        ),
        SizedBox(height: widget.spacing),
        // TODO: change indicator (doesn't work normally)
        SliderDots(
          controller: pageController,
          count: widget.count,
          size: widget.dotSize,
          spacing: widget.dotSpacing,
        )
      ],
    );
  }
}

class SliderDots extends StatelessWidget {
  final PageController controller;
  final int count;
  final double size;
  final double spacing;

  const SliderDots({
    super.key,
    required this.controller,
    required this.count,
    required this.size,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      effect: WormEffect(
        activeDotColor: CCAppColors.primary,
        dotColor: CCAppColors.lightHighlightBackground,
        dotHeight: size,
        dotWidth: size,
        spacing: spacing,
      ),
      controller: controller,
      count: count,
    );
  }
}
