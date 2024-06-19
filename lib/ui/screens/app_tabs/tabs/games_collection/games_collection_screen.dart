import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/view_model/games_collection_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/game_thumbnail.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        _SearchAppBar(),
        _GamesCollectionList(),
        SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 45)),
      ],
    );
  }
}

class _GamesCollectionList extends StatelessWidget {
  const _GamesCollectionList();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<GamesCollectionScreenViewModel>();
    final state = context.watch<GamesCollectionScreenViewModel>().state;

    final searchQuery = state.searchString;
    final filters = state.filters;

    return FutureBuilder<Map<dynamic, dynamic>>(
      future: viewModel.loadGamesCollection(
        searhQuery: searchQuery,
        filters: filters,
      ),
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
          return SliverToBoxAdapter(
            child: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        final games = viewModel.getGamesListFromData(snapshot.data);

        const double spacing = 10;
        final mainAxisExtent =
            (CCDeviceUtils.getScreenWidth(context) - spacing) / 2 + 37;

        return SliverGrid.builder(
          itemCount: games.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            mainAxisExtent: mainAxisExtent,
          ),
          itemBuilder: (_, index) => GameThumbnail(
            game: games[index],
            onTap: (game) => viewModel.onGameThumbnailPressed(context, game),
          ),
        );
      },
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  const _SearchAppBar();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<GamesCollectionScreenViewModel>();
    return SliverAppBar(
      titleSpacing: 0,
      backgroundColor: CCAppColors.lightBackground,
      toolbarHeight: 105,
      snap: true,
      floating: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      title: SearchTopBar(
        searchController: viewModel.searchController,
        onSubmitted: viewModel.onSearchSubmitted,
        actions: const [
          _RandomGameButton(),
          SizedBox(width: 7),
          _SearchFiltersButton(),
        ],
      ),
    );
  }
}

class _RandomGameButton extends StatelessWidget {
  const _RandomGameButton();

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();
    return CustomIconButton(
      icon: Iconsax.colorfilter_copy,
      onPressed: () async {
        final gameFuture = model.loadRandomGame();
        await model.onRandomGameButtonPressed(
          context,
          builder: (_) {
            return FutureBuilder(
              future: gameFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    break;
                }

                if (snapshot.hasData && !snapshot.hasError) {
                  final game = Game.fromJson(snapshot.data!);
                  return _RandomGameThumbnail(
                    onTap: (game) async {
                      await model.onGameThumbnailPressed(context, game);
                    },
                    game: game,
                  );
                }
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Ошибка загрузки случайной игры'),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _RandomGameThumbnail extends StatelessWidget {
  final void Function(Game game) onTap;

  const _RandomGameThumbnail({
    required this.game,
    required this.onTap,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => onTap(game),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Text(
              'Бросили кубик и выпала игра',
              style: TextStyle(
                fontSize: 16,
                color: CCAppColors.secondary,
              ),
            ),
            Text(game.name, style: const TextStyle(fontSize: 25)),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 1,
                child: Uri.tryParse(game.coverLink)?.hasAbsolutePath ?? false
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: game.coverLink,
                        errorWidget: (_, __, ___) =>
                            const Icon(Iconsax.game_copy),
                      )
                    : const Center(
                        child: Icon(
                          Iconsax.game_copy,
                          size: 45,
                          color: CCAppColors.secondary,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FiltersList extends StatefulWidget {
  final Function(GameCollectionFilters) onApply;
  final VoidCallback onClear;
  final GameCollectionFilters filters;

  const _FiltersList({
    required this.onApply,
    required this.filters,
    required this.onClear,
  });

  @override
  State<_FiltersList> createState() => _FiltersListState();
}

class _FiltersListState extends State<_FiltersList> {
  late GameCollectionFilters updatedFilters;

  @override
  void initState() {
    super.initState();
    updatedFilters = widget.filters;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Text(
            'Фильтры',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _AgeLimit(
            widget.filters.ageLimitFilter,
            (value) {
              updatedFilters = updatedFilters.copyWith(ageLimitFilter: value);
            },
          ),
          const Divider(
            color: CCAppColors.lightSectionBackground,
            thickness: 1,
            height: 30,
          ),
          _Complexity(
            widget.filters.complexityLimitFilter,
            (value) {
              updatedFilters =
                  updatedFilters.copyWith(complexityLimitFilter: value);
            },
          ),
          const Divider(
            color: CCAppColors.lightSectionBackground,
            thickness: 1,
            height: 30,
          ),
          _PlayersRangeSlider(
            (values) {
              updatedFilters = updatedFilters.copyWith(
                playersRangeFilter: [
                  values.start.toInt(),
                  values.end.toInt(),
                ],
              );
            },
            widget.filters.playersRangeFilter,
          ),
          const SizedBox(height: 35),
          _DurationRangeSlider(
            (values) {
              updatedFilters = updatedFilters.copyWith(
                durationRangeFilter: [
                  values.start.toInt(),
                  values.end.toInt(),
                ],
              );
            },
            widget.filters.durationRangeFilter,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: widget.onClear,
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 17, horizontal: 25),
                  ),
                ),
                child: const Text(
                  'Сбросить',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onApply(updatedFilters);
                },
                child: const Text('Применить'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Complexity extends StatelessWidget {
  final int complexity;
  final ValueChanged<int> onChanged;
  const _Complexity(this.complexity, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Сложность', style: TextStyle(fontSize: 18)),
        NumericStepButton(
          value: complexity,
          minValue: 1,
          maxValue: 5,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _AgeLimit extends StatelessWidget {
  final ValueChanged<int> onChanged;
  final int ageLimit;
  const _AgeLimit(this.ageLimit, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Возраст', style: TextStyle(fontSize: 18)),
        NumericStepButton(
          value: ageLimit,
          minValue: 0,
          maxValue: 18,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _PlayersRangeSlider extends StatefulWidget {
  final ValueChanged<RangeValues> onChanged;
  final List<int> playersRange;
  const _PlayersRangeSlider(this.onChanged, this.playersRange);

  @override
  State<_PlayersRangeSlider> createState() => _PlayersRangeSliderState();
}

class _PlayersRangeSliderState extends State<_PlayersRangeSlider> {
  int min = 2;
  int max = 12;

  @override
  void initState() {
    super.initState();
    min = widget.playersRange[0];
    max = widget.playersRange[1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Кол-во игроков', style: TextStyle(fontSize: 18)),
            const Spacer(),
            Text('$min'),
            const SizedBox(width: 10),
            Container(
              width: 20,
              height: 1,
              color: CCAppColors.lightHighlightBackground,
            ),
            const SizedBox(width: 10),
            Text('$max'),
          ],
        ),
        const SizedBox(height: 15),
        DynamicRangeSlider(
          min: 2,
          max: 12,
          onChanged: (RangeValues rangeValues) {
            setState(() {
              min = rangeValues.start.toInt();
              max = rangeValues.end.toInt();
            });
            widget.onChanged(rangeValues);
          },
          values: RangeValues(widget.playersRange[0].toDouble(),
              widget.playersRange[1].toDouble()),
        ),
      ],
    );
  }
}

class _DurationRangeSlider extends StatefulWidget {
  final ValueChanged<RangeValues> onChanged;
  final List<int> durationRangeFilter;
  const _DurationRangeSlider(this.onChanged, this.durationRangeFilter);

  @override
  State<_DurationRangeSlider> createState() => _DurationRangeSliderState();
}

class _DurationRangeSliderState extends State<_DurationRangeSlider> {
  int min = 1;
  int max = 400;

  @override
  void initState() {
    super.initState();
    min = widget.durationRangeFilter[0];
    max = widget.durationRangeFilter[1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Длительность, мин', style: TextStyle(fontSize: 18)),
            const Spacer(),
            Text('$min'),
            const SizedBox(width: 10),
            Container(
              width: 20,
              height: 1,
              color: CCAppColors.lightHighlightBackground,
            ),
            const SizedBox(width: 10),
            Text('$max'),
          ],
        ),
        const SizedBox(height: 15),
        DynamicRangeSlider(
          min: 1,
          max: 400,
          onChanged: (RangeValues rangeValues) {
            setState(() {
              min = rangeValues.start.toInt();
              max = rangeValues.end.toInt();
            });
            widget.onChanged(rangeValues);
          },
          values: RangeValues(widget.durationRangeFilter[0].toDouble(),
              widget.durationRangeFilter[1].toDouble()),
        ),
      ],
    );
  }
}

class _SearchFiltersButton extends StatelessWidget {
  const _SearchFiltersButton();

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();

    final filters =
        context.watch<GamesCollectionScreenViewModel>().state.filters;
    return CustomIconButton(
      icon: Iconsax.candle_2_copy,
      onPressed: () async {
        model.onSearchFiltersButtonPressed(
          context,
          builder: (BuildContext context) {
            return _FiltersList(
              onApply: (filters) =>
                  model.onFiltersApplyButtonPressed(filters, context),
              filters: filters,
              onClear: () => model.onFiltersClearButtonPressed(context),
            );
          },
        );
      },
    );
  }
}
