import 'package:cubik_club/ui/common/widgets/components/coins_indicator.dart';
import 'package:cubik_club/ui/common/widgets/components/custom_icon_button.dart';
import 'package:cubik_club/ui/common/widgets/components/post_thumbnail.dart';
import 'package:cubik_club/ui/common/widgets/components/custom_slider.dart';
import 'package:cubik_club/ui/common/widgets/search_top_bar.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/screens/scanner/scanner_screen.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class _ViewModelState {}

class _ViewModel extends ChangeNotifier {
  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void onQrScannerButtonPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ScannerScreen();
    }));
  }

  void onSliderPageChanged(int index) {}
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
    final model = context.read<_ViewModel>();
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SearchTopBar(
                actions: [
                  CoinsIndicator(value: 112),
                  SizedBox(width: 7),
                  _QRCodeScanner(),
                ],
              ),
              CustomSlider(
                count: 5,
                height: 360,
                onPageChanged: (index) => model.onSliderPageChanged(index),
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: CCAppColors.lightHighlightBackground,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(child: Text('Картинка ${index + 1}')),
                  );
                },
              ),
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

class _QRCodeScanner extends StatelessWidget {
  const _QRCodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return CustomIconButton(
      icon: Iconsax.scanner_copy,
      onPressed: () => model.onQrScannerButtonPressed(context),
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
              const SizedBox(width: 5),
              CustomIconButton(
                icon: Iconsax.candle_2_copy,
                onPressed: widget.onFiltersPressed,
              )
            ],
          ),
        ),
      ],
    );
  }
}
