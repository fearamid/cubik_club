import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class GameDescription extends StatelessWidget {
  final String name;
  final String description;

  const GameDescription({
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
          const Text(
            'Описание',
            style: TextStyle(
              color: CCAppColors.lightTextPrimary,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: CCAppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
