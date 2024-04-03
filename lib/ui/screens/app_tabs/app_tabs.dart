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
      bottomNavigationBar: _AppBottomNavigation(pageIndex: selectedPageIndex),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: viewModel.controller,
        children: viewModel.bottomNavigationScreens,
      ),
    );
  }
}

class _AppBottomNavigation extends StatelessWidget {
  final int pageIndex;
  const _AppBottomNavigation({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AppTabsViewModel>();
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: ClipRRect(
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.grid_4_copy,
                size: 35,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.grid_4, size: 35),
              label: 'Помощник',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.clock_copy,
                size: 35,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.clock, size: 35),
              label: 'События',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home_2_copy,
                size: 35,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.home_2, size: 35),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.copy_copy,
                size: 35,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.copy, size: 35),
              label: 'Коллекция',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.frame_1_copy,
                size: 35,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.frame, size: 35),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
