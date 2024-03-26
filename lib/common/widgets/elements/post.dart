import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Переход на пост');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: CCAppColors.lightSectionBackground,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Томатная атака',
              style: TextStyle(
                color: CCAppColors.lightTextPrimary,
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'Играем, развлекаемся и получаем удовольствие! Ждем всех желающих.',
              style: TextStyle(
                color: CCAppColors.lightTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'стратегия',
                  style: TextStyle(
                    color: CCAppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.18,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CCAppColors.lightHighlightBackground,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  '12+',
                  style: TextStyle(
                    color: CCAppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.18,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CCAppColors.lightHighlightBackground,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'для всех',
                  style: TextStyle(
                    color: CCAppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 335,
              decoration: const BoxDecoration(
                color: CCAppColors.lightHighlightBackground,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
