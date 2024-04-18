import 'package:cubik_club/ui/common/components/single/custom_icon_button.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/common/components/search_top_bar.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';

import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: delete magic numbers
    final collectionItemHeight =
        (CCDeviceUtils.getScreenWidth(context) - 10) / 2 + 10 + 100;

    final model = context.read<GamesCollectionScreenViewModel>();

    return CustomScrollView(
      slivers: [
        // TODO: convert topBar to SliverAppBar on all screens (it need?)
        SliverAppBar(
          titleSpacing: 0,
          backgroundColor: CCAppColors.lightBackground,
          toolbarHeight: 110,
          pinned: true,
          snap: true,
          floating: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          title: SearchTopBar(
            top: 30,
            actions: [
              CustomIconButton(
                icon: Iconsax.colorfilter_copy,
                onPressed: () {
                  model.onRandomGameButtonPressed(
                    context,
                    builder: (context) {
                      return Text('fsdfsdfsdff');
                    },
                  );
                },
              ),
              const SizedBox(width: 7),
              CustomIconButton(
                icon: Iconsax.candle_2_copy,
                onPressed: model.onSearchFiltersButtonPressed,
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // SearchTopBar(
              //   actions: [
              //     CustomIconButton(
              //       icon: Iconsax.colorfilter_copy,
              //       onPressed: model.onRandomGameButtonPressed,
              //     ),
              //     const SizedBox(width: 7),
              //     CustomIconButton(
              //       icon: Iconsax.candle_2_copy,
              //       onPressed: model.onSearchFiltersButtonPressed,
              //     ),
              //   ],
              // ),
              // const _SearchResultsViewBar(),
              // const SizedBox(height: 20),
            ],
          ),
        ),

        SliverGrid.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            mainAxisExtent: collectionItemHeight,
          ),
          itemBuilder: (context, index) {
            return const GameCard();
          },
        ),
        const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 60)),
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tap on game card');
      },
      child: const Section(
        paddingHorizontal: 15,
        paddingVertical: 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: AssetImage(CCImages.gameOpt),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Роскошь Дуэль',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 5),
            Text(
              'стратегия',
              style: TextStyle(
                fontSize: 18,
                color: CCAppColors.secondary,
                fontWeight: FontWeight.normal,
                height: 1,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            Text(
              '5 - 10 человек',
              style: TextStyle(
                fontSize: 18,
                color: CCAppColors.secondary,
                fontWeight: FontWeight.normal,
                height: 1,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            Text(
              '40 минут',
              style: TextStyle(
                fontSize: 18,
                color: CCAppColors.secondary,
                fontWeight: FontWeight.normal,
                height: 1,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class _DropDownFilters extends StatelessWidget {
  const _DropDownFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();

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
        onChanged: (index) => model.onDropDownFiltersChanged(index),
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
  static const IconData listIcon = Iconsax.row_horizontal_copy;
  static const IconData gridIcon = Iconsax.row_vertical_copy;

  late CollectionDisplayMode mode;
  late IconData icon;

  @override
  void initState() {
    super.initState();
    final viewMode =
        context.read<GamesCollectionScreenViewModel>().state.displayMode;

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
    final viewModel = context.read<GamesCollectionScreenViewModel>();

    return IconButton(
      icon: Icon(
        icon,
        size: 35,
        color: CCAppColors.secondary,
      ),
      onPressed: () {
        toggleMode();
        viewModel.onCollectionViewModeButtonPressed(mode);
      },
    );
  }
}
