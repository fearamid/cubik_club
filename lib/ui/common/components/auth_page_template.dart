import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class _AuthPageHeader extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  static const double imageMargin = 13;
  static const double titleMargin = 5;

  const _AuthPageHeader({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(image),
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        const SizedBox(height: imageMargin),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: titleMargin),
        Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _AuthPageActions extends StatelessWidget {
  final Widget mainAction;
  final Widget optionalAction;
  final List<Widget>? extraActions;
  final bool isHorizontal;

  static const double spacing = 15;

  const _AuthPageActions({
    required this.mainAction,
    required this.optionalAction,
    this.extraActions,
    this.isHorizontal = true,
  });

  Widget _createFlex() {
    return Flex(
      direction: isHorizontal ? Axis.horizontal : Axis.vertical,
      verticalDirection: VerticalDirection.up,
      children: [
        isHorizontal ? Flexible(child: optionalAction) : optionalAction,
        SizedBox(
          height: !isHorizontal ? spacing : 0,
          width: isHorizontal ? spacing : 0,
        ),
        isHorizontal ? Flexible(child: mainAction) : mainAction,
      ],
    );
  }

  Widget _createActions() {
    if (extraActions == null) return _createFlex();

    List<Widget> actions = [];
    actions.add(_createFlex());
    actions.addAll(extraActions!.map((Widget e) => e));

    return Column(
      children: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createActions();
  }
}

class AuthPageTemplate extends StatelessWidget {
  final List<Widget> body;
  final Widget mainAction;
  final Widget optionalAction;
  final double marginBodyTop;
  final double marginBodyBottom;
  final String image;
  final String title;
  final String subtitle;
  final bool isActionsHorizontal;
  final List<Widget>? extraActions;

  static const double padding = 20;

  const AuthPageTemplate({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.mainAction,
    required this.optionalAction,
    required this.body,
    this.marginBodyTop = 30,
    this.marginBodyBottom = 60,
    this.isActionsHorizontal = true,
    this.extraActions,
  });

  List<Widget> _createPage() {
    List<Widget> page = [];

    page.add(
      _AuthPageHeader(image: image, title: title, subTitle: subtitle),
    );
    page.add(SizedBox(height: marginBodyTop));
    page.addAll(body.map((Widget item) => item));
    page.add(SizedBox(height: marginBodyBottom));
    page.add(
      _AuthPageActions(
        mainAction: mainAction,
        optionalAction: optionalAction,
        extraActions: extraActions,
        isHorizontal: isActionsHorizontal,
      ),
    );

    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: CCDeviceUtils.getAppBarHeight(),
        left: padding,
        right: padding,
        bottom: padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _createPage(),
      ),
    );
  }
}
