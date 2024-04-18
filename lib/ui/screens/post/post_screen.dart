import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/screens/post/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final BuildContext buildContext;
  final Event event;

  const PostScreen({
    super.key,
    required this.event,
    required this.buildContext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: Container(
      //   decoration: const BoxDecoration(
      //     color: CCAppColors.lightBackground,
      //     shape: BoxShape.circle,
      //   ),
      //   child: CustomIconButton(
      //     icon: Iconsax.arrow_left_2_copy,
      //     onPressed: () {},
      //   ),
      // ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   pinned: true,
          //   floating: true,
          //   expandedHeight: 370,
          //   toolbarHeight: 0,
          //   collapsedHeight: 0,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: CCAppColors.lightBackground,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: ClipRRect(
          //       borderRadius: const BorderRadius.only(
          //         bottomRight: Radius.circular(20),
          //         bottomLeft: Radius.circular(20),
          //       ),
          //       child: Image.asset(
          //         CCImages.cowboy,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildListDelegate([
              // const SizedBox(height: kToolbarHeight),
              const PostCover(),
              const SizedBox(height: 20),
              PostDescription(
                name: event.name,
                description: event.description,
              ),
              const SizedBox(height: 20),
              const GamesList(["Монополия", "Другая игра"]),
              const SizedBox(height: kBottomNavigationBarHeight + 60),
            ]),
          )
        ],
      ),
    );
  }
}
