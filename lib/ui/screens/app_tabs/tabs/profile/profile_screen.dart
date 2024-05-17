import 'package:cubik_club/domain/entities/user.dart';
import 'package:cubik_club/ui/common/components/single/coins_indicator.dart';
import 'package:cubik_club/ui/common/components/single/custom_icon_button.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/profile/profile_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User>? _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = context.read<ProfileScreenViewModel>().getUserDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            User? userData = snapshot.data;
            if (snapshot.hasError || userData == null) {
              print(snapshot.error);
              print(userData);
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      const [
                        _ProfileHeader(),
                        _UserResources(),
                        _UserAchievements(),
                        _BookingInformation(),
                        SizedBox(height: 20),
                        _ClubInformation(),
                        SizedBox(height: kBottomNavigationBarHeight + 45)
                      ],
                    ),
                  ),
                ],
              );
            }

            context
                .read<ProfileScreenViewModel>()
                .updateStateWithoutNotification(user: userData);

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    const [
                      _ProfileHeader(),
                      _UserResources(),
                      _UserAchievements(),
                      _BookingInformation(),
                      SizedBox(height: 20),
                      _ClubInformation(),
                      SizedBox(height: kBottomNavigationBarHeight + 45)
                    ],
                  ),
                ),
              ],
            );
          default:
            return const Center(child: Text('Ошибка'));
        }
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
        top: 25,
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
  const _UserInformation();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileScreenViewModel>().state.user;
    return Expanded(
      child: Column(
        children: [
          const CircleAvatar(
            maxRadius: 95,
            backgroundImage: AssetImage(CCImages.accountCreateStep2),
          ),
          const SizedBox(height: 15),
          Text(
            '${user.name} ${user.surname}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: CCAppColors.lightTextPrimary,
              height: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${user.login}',
            textAlign: TextAlign.center,
            style: const TextStyle(
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

// class _UserInformation extends StatelessWidget {
//   const _UserInformation();

//   @override
//   Widget build(BuildContext context) {
//     final user = context.watch<ProfileScreenViewModel>().state.user;
//     final viewModel = context.read<ProfileScreenViewModel>();
//     return FutureBuilder<User>(
//       future: viewModel.getUserDataAsync(),
//       builder: (context, snapshot) {
//         User? userData = snapshot.data;
//         // if (userData == null) {
//         //   userData == User.empty();
//         // }
//         // viewModel.updateState(user: userData);

//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return Expanded(
//               child: Column(
//                 children: [
//                   const CircleAvatar(
//                     maxRadius: 95,
//                     backgroundColor: CCAppColors.lightSectionBackground,
//                   ),
//                   const SizedBox(height: 15),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 20),
//                     width: double.maxFinite,
//                     height: 25,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: CCAppColors.lightSectionBackground,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 50),
//                     width: double.maxFinite,
//                     height: 25,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: CCAppColors.lightSectionBackground,
//                     ),
//                   ),
//                 ],
//               ),
//             );

//           default:
//             return Expanded(
//               child: Column(
//                 children: [
//                   const CircleAvatar(
//                     maxRadius: 95,
//                     backgroundImage: AssetImage(CCImages.accountCreateStep2),
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     '${userData?.name} ${userData?.surname}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w700,
//                       color: CCAppColors.lightTextPrimary,
//                       height: 1,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     '${userData?.login}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w400,
//                       color: CCAppColors.lightTextSecodary,
//                       height: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//         }
//       },
//     );
//   }
// }

class _ActionsBar extends StatelessWidget {
  const _ActionsBar();

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
              onPressed: () => model.onQrCodeButtonPressed(context),
            ),
            const SizedBox(height: 15),
            CustomIconButton(
              icon: Iconsax.brush_3_copy,
              onPressed: () {},
            ),
            const SizedBox(height: 15),
            CustomIconButton(
              icon: Iconsax.folder_copy,
              onPressed: () => model.onFoldersButtonPressed(context),
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
  const _UserAchievements();

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
                'DnD профиль',
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
  const _BookingInformation();

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
  const _ClubInformation();

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
