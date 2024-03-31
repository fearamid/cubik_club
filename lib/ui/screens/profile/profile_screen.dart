import 'package:cubik_club/common/widgets/components/coins_indicator.dart';
import 'package:cubik_club/common/widgets/components/custom_icon_button.dart';
import 'package:cubik_club/common/widgets/components/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class _ViewModelState {}

class _ViewModel extends ChangeNotifier {
  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void updateState() {
    _state = _ViewModelState();
    notifyListeners();
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const _ProfileHeader(),
              const _UserResources(),
              const _UserAchievements(),
            ],
          ),
        ),
        const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 60)),
      ],
    );
  }
}

class _UserAchievements extends StatelessWidget {
  const _UserAchievements({super.key});

  Color pickColorFromIndex(int index) {
    final clasterNumber = (index + 1) % 4;
    switch (clasterNumber) {
      case 1:
        return CCAppColors.accentRed;
      case 2:
        return CCAppColors.accentBlue;
      case 3:
        return CCAppColors.accentGreen;
      case 0:
        return CCAppColors.accentYellow;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return Section(
          alignment: Alignment.center,
          color: pickColorFromIndex(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$index'),
              const Text('Подробнее'),
            ],
          ),
        );
      },
    );
  }
}

class _UserResources extends StatelessWidget {
  const _UserResources({super.key});

  @override
  Widget build(BuildContext context) {
    return const Section(
      paddingVertical: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CoinsIndicator(value: 125),
          CoinsIndicator(value: 125),
          CoinsIndicator(value: 125),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
        top: kToolbarHeight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _UserInformation(),
          SizedBox(width: 20),
          _ActionsBar(),
        ],
      ),
    );
  }
}

class _UserInformation extends StatelessWidget {
  const _UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 95,
            backgroundImage: AssetImage(CCImages.accountCreateStep2),
          ),
          SizedBox(height: 15),
          Text(
            'Софи Оганнисян',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: CCAppColors.lightTextPrimary,
              height: 1,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'mega_gamer123',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: CCAppColors.lightTextSecodary,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionsBar extends StatelessWidget {
  const _ActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: CCAppColors.lightHighlightBackground,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Iconsax.setting_copy,
              onPressed: () {},
            ),
            const SizedBox(height: 15),
            CustomIconButton(
              icon: Iconsax.maximize_21_copy,
              onPressed: () {},
            ),
            const SizedBox(height: 15),
            CustomIconButton(
              icon: Iconsax.brush_3_copy,
              onPressed: () {},
            ),
            const SizedBox(height: 15),
            CustomIconButton(
              icon: Iconsax.folder_copy,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
