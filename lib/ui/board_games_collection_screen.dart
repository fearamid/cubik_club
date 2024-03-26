import 'package:cubik_club/common/widgets/elements/search_input.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {}

class BoardGamesCollectionScreen extends StatelessWidget {
  const BoardGamesCollectionScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const BoardGamesCollectionScreen(),
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
              const _SearchResultsView(),
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
            return const _BoardGameCard();
          },
        ),
      ],
    );
  }
}

class _BoardGameCard extends StatelessWidget {
  const _BoardGameCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: CCAppColors.lightSectionBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
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
        Positioned(
          left: 20,
          child: Container(
            width: 10,
            height: 10,
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}

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
          Icon(
            Icons.circle_outlined,
            size: 40,
            color: CCAppColors.secondary,
          ),
          SizedBox(width: 20),
          Icon(
            Icons.settings_outlined,
            size: 40,
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

class _SearchResultsView extends StatelessWidget {
  const _SearchResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CCAppColors.lightSectionBackground,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _DropDownFilters(),
          Icon(
            Icons.rectangle_outlined,
            color: CCAppColors.secondary,
            size: 40,
          )
        ],
      ),
    );
  }
}
