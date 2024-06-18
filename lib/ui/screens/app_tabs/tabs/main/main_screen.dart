import 'package:cubik_club/domain/entities/article.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/main/main_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MainScreenViewModel>();
    return RefreshIndicator(
      backgroundColor: CCAppColors.lightBackground,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      strokeWidth: 2,
      onRefresh: viewModel.onRefreshPage,
      child: CustomScrollView(
        slivers: [
          const _SearchBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _PostsCarousel(),
                const SizedBox(height: 20),
                const _ArticlesSlider(
                  guides: [
                    Article(
                      image: CCImages.tomato,
                      title: 'Как нас найти?',
                      text: 'Мы по адресу...',
                    ),
                    Article(
                      image: CCImages.cowboy,
                      title: 'Как нас найти?',
                      text: 'Мы по адресу...',
                    ),
                    Article(
                      image: CCImages.tomato,
                      title: 'Как нас найти?',
                      text: 'Мы по адресу...',
                    ),
                    Article(
                      image: CCImages.cowboy,
                      title: 'Как нас найти?',
                      text: 'Мы по адресу...',
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                const _PostCategoryTabBar(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const _FeedList(),
          const SliverToBoxAdapter(
              child: SizedBox(height: kBottomNavigationBarHeight + 60)),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      popButton: false,
      height: 85,
      actions: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SearchInput(
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      print(value);
                    }
                  },
                ),
                const SizedBox(width: 20),
                const CoinsIndicator(value: 112),
                const SizedBox(width: 7),
                const _QRCodeScanner(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _FeedList extends StatelessWidget {
  const _FeedList();

  FutureBuilder createEventsList(BuildContext context) {
    final viewModel = context.read<MainScreenViewModel>();
    return FutureBuilder<List<Map<dynamic, dynamic>>>(
      future: viewModel.loadRelevantEvents(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('Загружаем данные...'),
              ),
            );
          case ConnectionState.done:
            break;
          default:
        }

        if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('Ошибка загрузки данных...'),
            ),
          );
        }
        final events = snapshot.data;

        return SliverList.separated(
          itemCount: events?.length,
          itemBuilder: (context, index) {
            final event = viewModel.parseEvent(events?[index]);

            return EventThumbnail(event: event);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        );
      },
    );
  }

  FutureBuilder createReportsList(BuildContext context) {
    final viewModel = context.read<MainScreenViewModel>();
    return FutureBuilder<List<Map<dynamic, dynamic>>>(
      future: viewModel.loadRelevantEvents(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('Загружаем данные...'),
              ),
            );
          case ConnectionState.done:
            break;
          default:
        }

        if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('Ошибка загрузки данных...'),
            ),
          );
        }
        final events = snapshot.data;

        return SliverList.separated(
          itemCount: events?.length,
          itemBuilder: (context, index) {
            final event = viewModel.parseEvent(events?[index]);

            return EventThumbnail(event: event);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryType =
        context.watch<MainScreenViewModel>().state.currentTabsCategory;

    switch (categoryType) {
      case TabsCategoryType.announcements:
        return createEventsList(context);
      case TabsCategoryType.reports:
        return createReportsList(context);
      case TabsCategoryType.other:
        return SliverToBoxAdapter(child: Text('Другое'));
      default:
        return SliverToBoxAdapter(child: Text('Ошибка'));
    }
  }
}

class _PostsCarousel extends StatelessWidget {
  const _PostsCarousel();

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenViewModel>();
    final sliderPosts = context.read<MainScreenViewModel>().state.sliderPosts;
    final count = sliderPosts.length;

    return CustomSlider(
      count: count == 0 ? 1 : count,
      height: 360,
      onPageChanged: model.onSliderPageChanged,
      itemBuilder: (_, index, __) {
        if (count == 0) {
          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: CCAppColors.lightHighlightBackground,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Center(child: Text('Никаких объявлений')),
          );
        }

        return GestureDetector(
          onTap: () => model.onSliderPagePressed(index),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              CCImages.cowboy,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

class _ArticlesSlider extends StatelessWidget {
  const _ArticlesSlider({
    required this.guides,
  });

  final List<Article> guides;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: guides.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ArticleThumbnail(
            guide: guides[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}

class ArticleThumbnail extends StatelessWidget {
  const ArticleThumbnail({
    super.key,
    required this.guide,
  });

  final Article guide;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: article screen
        MainNavigation.toEventcreen(
          context,
          event: Event(
            id: 0,
            title: 'Заглушка',
            description: 'Сделать новый класс под guide',
            coverLink: '',
            startDateTime: DateTime.now(),
            endDateTime: DateTime.now(),
          ),
        );
      },
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(guide.image),
            fit: BoxFit.cover,
          ),
          color: CCAppColors.lightSectionBackground,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: const Border.fromBorderSide(
            BorderSide(
              color: CCAppColors.lightHighlightBackground,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _QRCodeScanner extends StatelessWidget {
  const _QRCodeScanner();

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenViewModel>();
    return CustomIconButton(
      icon: Iconsax.scanner_copy,
      onPressed: () => model.onQrScannerButtonPressed(context),
    );
  }
}

// ---------- Post Tabs ----------

class _PostCategoryTabBar extends StatefulWidget {
  const _PostCategoryTabBar();

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
    final model = context.read<MainScreenViewModel>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TabBar(
                  onTap: model.onTabPressed,
                  controller: _tabController,
                  dividerHeight: 0,
                  labelPadding: EdgeInsets.zero,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  unselectedLabelColor: CCAppColors.secondary,
                  labelColor: CCAppColors.lightBackground,
                  labelStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  indicator: const BoxDecoration(
                    color: CCAppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(text: 'Анонсы'),
                    Tab(text: 'Отчеты'),
                    Tab(text: 'Другое'),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              CustomIconButton(
                icon: Iconsax.candle_2_copy,
                onPressed: model.onFiltersPressed,
              )
            ],
          ),
        ),
      ],
    );
  }
}
