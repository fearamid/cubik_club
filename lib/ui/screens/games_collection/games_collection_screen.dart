import 'package:cubik_club/common/widgets/elements/search_input.dart';
import 'package:cubik_club/common/widgets/elements/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/icons.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum CollectionDisplayMode { list, grid }

class _ViewModelState {
  final CollectionDisplayMode displayMode;

  _ViewModelState({
    this.displayMode = CollectionDisplayMode.list,
  });
}

class _ViewModel extends ChangeNotifier {
  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void updateState({
    CollectionDisplayMode? displayMode,
  }) {
    _state = _ViewModelState(
      displayMode: displayMode ?? _state.displayMode,
    );
    notifyListeners();
  }

  void onRandomGameButtonPressed() {}

  void onSearchFiltersButtonPressed() {}

  void onCollectionViewModeButtonPressed(CollectionDisplayMode mode) {
    updateState(
      displayMode: mode,
    );
  }
}

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const GamesCollectionScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // TODO: convert topBar to SliverAppBar on all screens

        SliverList(
          delegate: SliverChildListDelegate(
            [
              const _TopBar(),
              const _SearchResultsViewBar(),
              const SizedBox(height: 20),
            ],
          ),
        ),

        SliverGrid.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 280,
          ),
          itemBuilder: (context, index) {
            return const _GameCard();
          },
        ),
        const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 60)),
      ],
    );
  }
}

class _GameCard extends StatelessWidget {
  const _GameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tap on game card');
      },
      child: const Section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: AssetImage(CCImages.gameOpt),
              ),
            ),
            Spacer(),
            Text(
              'Роскошь Дуэль',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'стратегия, 40 мин, 5-10 человек',
              style: TextStyle(
                fontSize: 16,
                height: 1.3,
                fontWeight: FontWeight.normal,
                color: CCAppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 20,
        right: 20,
        top: kToolbarHeight,
      ),
      child: Row(
        children: [
          const SearchInput(),
          const SizedBox(width: 20),
          IconButton(
            icon: Image.asset(
              CCAppIcons.random,
              width: 45,
              height: 30,
            ),
            padding: const EdgeInsets.all(10),
            onPressed: () {},
            color: CCAppColors.secondary,
          ),
          const SizedBox(width: 7),
          IconButton(
            icon: Image.asset(
              CCAppIcons.filters,
              width: 35,
              height: 35,
            ),
            padding: const EdgeInsets.all(10),
            onPressed: () {},
            color: CCAppColors.secondary,
          ),
        ],
      ),
    );
  }
}

class _DropDownFilters extends StatelessWidget {
  const _DropDownFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: 0,
        iconDisabledColor: CCAppColors.secondary,
        iconEnabledColor: CCAppColors.secondary,
        items: const [
          DropdownMenuItem(
            value: 0,
            child: Text(
              'Популярное',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: CCAppColors.secondary,
              ),
            ),
          ),
        ],
        onChanged: (index) {},
      ),
    );
  }
}

class _SearchResultsViewBar extends StatelessWidget {
  const _SearchResultsViewBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Section(
      paddingVertical: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _DropDownFilters(),
          CollectionDisplayModeButton(),
        ],
      ),
    );
  }
}

class CollectionDisplayModeButton extends StatefulWidget {
  const CollectionDisplayModeButton({super.key});

  @override
  State<CollectionDisplayModeButton> createState() =>
      _CollectionDisplayModeButtonState();
}

class _CollectionDisplayModeButtonState
    extends State<CollectionDisplayModeButton> {
  final listIcon = Image.asset(
    CCAppIcons.listView,
    height: 33,
    width: 33,
  );

  final gridIcon = Image.asset(
    CCAppIcons.gridView,
    height: 33,
    width: 33,
  );

  late CollectionDisplayMode mode;
  late Image icon;

  @override
  void initState() {
    super.initState();
    final viewMode = context.read<_ViewModel>().state.displayMode;

    mode = viewMode;
    icon = viewMode == CollectionDisplayMode.list ? gridIcon : listIcon;
  }

  void toggleMode() {
    if (mode == CollectionDisplayMode.list) {
      mode = CollectionDisplayMode.grid;
      icon = listIcon;
    } else {
      mode = CollectionDisplayMode.list;
      icon = gridIcon;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<_ViewModel>();

    return IconButton(
      icon: icon,
      onPressed: () {
        toggleMode();
        viewModel.onCollectionViewModeButtonPressed(mode);
      },
    );
  }
}
