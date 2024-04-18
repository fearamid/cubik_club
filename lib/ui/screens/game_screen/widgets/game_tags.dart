import 'package:cubik_club/ui/common/components/single/link_tile.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TagsList extends StatelessWidget {
  final List<String> games;

  const TagsList(
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
