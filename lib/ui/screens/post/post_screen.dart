import 'package:cubik_club/common/widgets/elements/section.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {}

class PostScreen extends StatelessWidget {
  final Event event;

  const PostScreen({super.key, required this.event});

  static Widget create(Event event) {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: PostScreen(event: event),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: kToolbarHeight),
            const _PostCover(),
            const SizedBox(height: 20),
            _PostDescription(
              name: event.name,
              description: event.description,
            ),
            const SizedBox(height: 20),
            const _GamesList(),
            const SizedBox(height: kBottomNavigationBarHeight + 60),
          ],
        ),
      ),
    );
  }
}

class _GamesList extends StatelessWidget {
  const _GamesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Section(
      child: Column(
        children: [],
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
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.grey,
            ),
            child: Image.asset(CCImages.onBoardingImage2),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: CCAppColors.lightBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
