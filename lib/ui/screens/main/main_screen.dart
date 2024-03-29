import 'package:carousel_slider/carousel_slider.dart';
import 'package:cubik_club/common/widgets/elements/coins_indicator.dart';
import 'package:cubik_club/common/widgets/elements/post_thumbnail.dart';
import 'package:cubik_club/common/widgets/elements/search_input.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/screens/scanner/scanner_screen.dart';
import 'package:cubik_club/utils/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class _ViewModelState {}

class _ViewModel extends ChangeNotifier {
  var _state = _ViewModelState();
  _ViewModelState get state => _state;
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const MainScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const _TopBar(),
              const _HeroSlider(),
              const SizedBox(height: 20),
              const _GuidesCarousel(),
              const SizedBox(height: 45),
              _PostCategoryTabBar(
                onFiltersPressed: () {},
                onTabPressed: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        SliverList.separated(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return EventThumbnail(
              event: Event(
                name: 'Мероприятие $index',
                description:
                    'Будем играть в такую очень интересную игру с увлекательными механиками. Возьмите с собой хорошее настроение, несколько часов свободного времени и наше приложение. Будем играть в такую очень интересную игру с увлекательными механиками. Возьмите с собой хорошее настроение, несколько часов свободного времени и наше приложение.',
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
        ),
        const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 60)),
      ],
    );
  }
}

class _GuidesCarousel extends StatelessWidget {
  const _GuidesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            decoration: const BoxDecoration(
              color: CCAppColors.lightSectionBackground,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.fromBorderSide(
                BorderSide(
                    color: CCAppColors.lightHighlightBackground, width: 2),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}

// ---------- Hero Slider ----------

class _HeroSlider extends StatefulWidget {
  const _HeroSlider({super.key});

  @override
  State<_HeroSlider> createState() => _HeroSliderState();
}

class _HeroSliderState extends State<_HeroSlider> {
  var pageController = PageController();
  final int itemsCount = 5;
  int currentItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: CarouselController(),
          itemCount: itemsCount,
          options: CarouselOptions(
            autoPlay: true,
            height: 360,
            viewportFraction: 1,
            onPageChanged: (int index, _) {
              print(index);
              setState(() {
                currentItemIndex = index;
                pageController = PageController(initialPage: currentItemIndex);
              });
            },
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
              decoration: const BoxDecoration(
                color: CCAppColors.lightHighlightBackground,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        // TODO: change indicator (doesn't work normally)
        SmoothPageIndicator(
          effect: const WormEffect(
            activeDotColor: CCAppColors.primary,
            dotColor: CCAppColors.lightHighlightBackground,
            dotHeight: 8,
            dotWidth: 8,
            spacing: 15,
          ),
          controller: pageController,
          count: itemsCount,
        ),
      ],
    );
  }
}

// ---------- Top Bar ----------

class _TopBar extends StatelessWidget {
  const _TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        bottom: 15,
        left: 20,
        right: 20,
        top: kToolbarHeight,
      ),
      child: Row(
        children: [
          SearchInput(),
          SizedBox(width: 25),
          CoinsIndicator(value: 112),
          SizedBox(width: 5),
          _QRCodeScanner(),
        ],
      ),
    );
  }
}

class _QRCodeScanner extends StatelessWidget {
  const _QRCodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.qr_code_scanner_rounded,
        color: CCAppColors.secondary,
        size: 40,
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const ScannerScreen();
        }));
      },
    );
  }
}

// ---------- Post Tabs ----------

class _PostCategoryTabBar extends StatefulWidget {
  final VoidCallback onTabPressed;
  final VoidCallback onFiltersPressed;

  const _PostCategoryTabBar({
    super.key,
    required this.onTabPressed,
    required this.onFiltersPressed,
  });

  @override
  State<_PostCategoryTabBar> createState() => _PostCategoryTabBarState();
}

class _PostCategoryTabBarState extends State<_PostCategoryTabBar>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TabBar(
                  controller: _tabController,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  dividerHeight: 0,
                  labelColor: CCAppColors.lightBackground,
                  unselectedLabelColor: CCAppColors.secondary,
                  labelPadding: EdgeInsets.zero,
                  labelStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  indicator: const BoxDecoration(
                      color: CCAppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'Анонсы'),
                    Tab(text: 'Отчеты'),
                    Tab(text: 'Другое'),
                  ],
                ),
              ),
              IconButton(
                  // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  onPressed: widget.onFiltersPressed,
                  icon:
                      const Icon(Icons.settings, color: CCAppColors.secondary))
            ],
          ),
        ),
      ],
    );
  }
}
