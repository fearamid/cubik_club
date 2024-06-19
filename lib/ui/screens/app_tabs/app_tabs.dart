import 'package:cubik_club/ui/screens/app_tabs/app_tabs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import 'package:cubik_club/utils/constants/colors.dart';

class AppTabs extends StatelessWidget {
  const AppTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AppTabsViewModel>();
    final selectedPageIndex =
        context.watch<AppTabsViewModel>().state.selectedPageIndex;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _AppBottomNavigation(
        pageIndex: selectedPageIndex,
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: viewModel.controller,
          children: viewModel.bottomNavigationScreens,
        ),
      ),
    );
  }
}

class _AppBottomNavigation extends StatelessWidget {
  final int pageIndex;
  final double iconSize;
  const _AppBottomNavigation({
    required this.pageIndex,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AppTabsViewModel>();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: CCAppColors.lightBackground,
        elevation: 1,
        currentIndex: pageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: viewModel.onBottomNavigationBarTap,
        fixedColor: CCAppColors.primary,
        items: [
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Iconsax.grid_4_copy,
          //     size: iconSize,
          //     color: CCAppColors.lightHighlightBackground,
          //   ),
          //   activeIcon: Icon(Iconsax.grid_4, size: iconSize),
          //   label: 'Помощник',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.clock_copy,
              size: iconSize,
              color: CCAppColors.lightHighlightBackground,
            ),
            activeIcon: Icon(Iconsax.clock, size: iconSize),
            label: 'События',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.home_2_copy,
              size: iconSize,
              color: CCAppColors.lightHighlightBackground,
            ),
            activeIcon: Icon(Iconsax.home_2, size: iconSize),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.copy_copy,
              size: iconSize,
              color: CCAppColors.lightHighlightBackground,
            ),
            activeIcon: Icon(Iconsax.copy, size: iconSize),
            label: 'Коллекция',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.frame_1_copy,
              size: iconSize,
              color: CCAppColors.lightHighlightBackground,
            ),
            activeIcon: Icon(Iconsax.frame, size: iconSize),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
