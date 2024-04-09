import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/user.dart';
import 'package:cubik_club/ui/common/widgets/components/coins_indicator.dart';
import 'package:cubik_club/ui/common/widgets/components/custom_icon_button.dart';
import 'package:cubik_club/ui/common/widgets/components/section.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/profile/profile_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              const _BookingInformation(),
              const SizedBox(height: 20),
              const _ClubInformation(),
            ],
          ),
        ),
        const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 60)),
      ],
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
    final model = context.read<ProfileScreenViewModel>();

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
              onPressed: () => model.onSettingsButtonPressed(context),
            ),
            const SizedBox(height: 15),
            CustomIconButton(
              icon: Iconsax.maximize_21_copy,
              onPressed: () {
                // TODO: change to User
                Navigator.of(context).pushNamed(
                  Screens.qrCode,
                  arguments: const User(
                    name: 'Дмитрий',
                    surname: 'Калашников',
                    id: 'user_283471023',
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            // CustomIconButton(
            //   icon: Iconsax.brush_3_copy,
            //   onPressed: () {},
            // ),
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
              Text(
                '$index',
                style: const TextStyle(fontSize: 18),
              ),
              const Text(
                'Подробнее',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BookingInformation extends StatelessWidget {
  const _BookingInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Бронирование",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Вы ничего не бронировали.',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class _ClubInformation extends StatelessWidget {
  const _ClubInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Информация клуба',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Посещения',
            style: TextStyle(fontSize: 18, color: CCAppColors.secondary),
          ),
          Text(
            'Участия',
            style: TextStyle(fontSize: 18, color: CCAppColors.secondary),
          ),
          Text(
            'Победы',
            style: TextStyle(fontSize: 18, color: CCAppColors.secondary),
          ),
          Text(
            'Звания лучшего',
            style: TextStyle(fontSize: 18, color: CCAppColors.secondary),
          ),
        ],
      ),
    );
  }
}
