import 'package:cubik_club/ui/common/widgets/components/custom_icon_button.dart';
import 'package:cubik_club/ui/common/widgets/components/link_tile.dart';
import 'package:cubik_club/ui/common/widgets/components/section.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PostScreen extends StatelessWidget {
  final BuildContext buildContext;
  final Event event;

  const PostScreen({
    super.key,
    required this.event,
    required this.buildContext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: Container(
      //   decoration: const BoxDecoration(
      //     color: CCAppColors.lightBackground,
      //     shape: BoxShape.circle,
      //   ),
      //   child: CustomIconButton(
      //     icon: Iconsax.arrow_left_2_copy,
      //     onPressed: () {},
      //   ),
      // ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   pinned: true,
          //   floating: true,
          //   expandedHeight: 370,
          //   toolbarHeight: 0,
          //   collapsedHeight: 0,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: CCAppColors.lightBackground,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: ClipRRect(
          //       borderRadius: const BorderRadius.only(
          //         bottomRight: Radius.circular(20),
          //         bottomLeft: Radius.circular(20),
          //       ),
          //       child: Image.asset(
          //         CCImages.cowboy,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildListDelegate([
              // const SizedBox(height: kToolbarHeight),
              const _PostCover(),
              const SizedBox(height: 20),
              _PostDescription(
                name: event.name,
                description: event.description,
              ),
              const SizedBox(height: 20),
              const _GamesList(["Монополия", "Другая игра"]),
              const SizedBox(height: kBottomNavigationBarHeight + 60),
            ]),
          )
        ],
      ),
    );
  }
}

class _GamesList extends StatelessWidget {
  final List<String> games;

  const _GamesList(
    this.games, {
    super.key,
  });

  List<Widget> _createChildren() {
    final count = games.length;
    List<Widget> children = [];

    children.addAll(_createTitle(count));
    children.addAll(_createBody(count).map((widget) => widget));

    return children;
  }

  List<Widget> _createTitle(int count) {
    String title = '';

    if (count == 0) {
      title = 'Игра отсутствует';
    } else if (count == 1) {
      title = games[0];
    } else {
      title = 'Играем в эти настолки';
    }

    return [
      Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: CCAppColors.lightTextPrimary,
        ),
      ),
      const SizedBox(height: 7),
    ];
  }

  List<Widget> _createBody(int count) {
    if (count == 0) {
      return [
        const Text(
          'У этого мероприятия отсутсвует назначенная игра.',
          style: TextStyle(
            fontSize: 18,
          ),
        )
      ];
    } else if (count == 1) {
      return _createSingleGameBody();
    }
    return [_createMultipleGamesBody(count)];
  }

  Widget _createMultipleGamesBody(int count) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        return LinkTile.withTags(
            onPressed: () {},
            title: games[index],
            tags: ["Стратегия", "18+", "Сложная"]);
      },
      separatorBuilder: (_, __) {
        return const SizedBox(height: 10);
      },
    );
  }

  List<Widget> _createSingleGameBody() {
    return [
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  'Параметр $index',
                  style: const TextStyle(
                    fontSize: 18,
                    color: CCAppColors.secondary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Значение $index',
                  style: const TextStyle(
                    fontSize: 18,
                    color: CCAppColors.lightTextPrimary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: 7);
        },
      ),
      const SizedBox(height: 15),
      OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          ),
        ),
        onPressed: () {},
        child: const Text('Подробнее'),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _createChildren(),
      ),
    );
  }
}

class _PostDescription extends StatelessWidget {
  final String name;
  final String description;

  const _PostDescription({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: CCAppColors.lightTextPrimary,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const Text(
                '16.08.2024',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: CCAppColors.lightTextSecodary,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: CCAppColors.lightHighlightBackground,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'с 15:00 до 22:30',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: CCAppColors.lightTextSecodary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: CCAppColors.lightTextPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 40, vertical: 17),
              ),
            ),
            child: const Text('Забронировать'),
          ),
        ],
      ),
    );
  }
}

class _PostCover extends StatelessWidget {
  const _PostCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(CCImages.tomato),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: CCAppColors.lightBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Iconsax.arrow_left_2_copy,
                size: 35,
                color: CCAppColors.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
