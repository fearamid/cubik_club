import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PostDescription extends StatelessWidget {
  final String name;
  final String description;

  const PostDescription({
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
