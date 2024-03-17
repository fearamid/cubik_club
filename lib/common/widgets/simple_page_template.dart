import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
abstract class SimplePageTemplate extends StatelessWidget {
  List<Widget>? header;
  List<Widget>? body;
  List<Widget>? actions;
  final double padding;
  final double marginBodyTop;
  final double marginBodyBottom;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  SimplePageTemplate({
    super.key,
    required this.header,
    required this.body,
    required this.actions,
    this.marginBodyTop = 30,
    this.marginBodyBottom = 60,
    this.padding = 20,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  SimplePageTemplate.withoutBody({
    super.key,
    required SimplePageTemplateHeader customHeader,
    required this.body,
    required SimplePageTemplateActions customActions,
    this.marginBodyTop = 30,
    this.marginBodyBottom = 40,
    this.padding = 20,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    header = [customHeader];
    actions = [customActions];
  }

  SimplePageTemplate.custom({
    super.key,
    required SimplePageTemplateHeader customHeader,
    required SimplePageTemplateBody customBody,
    required SimplePageTemplateActions customActions,
    required this.actions,
    required this.padding,
    required this.marginBodyTop,
    required this.marginBodyBottom,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  }) {
    header = [customHeader];
    body = [customBody];
    actions = [customActions];
  }

  List<Widget> _createPage() {
    List<Widget> page = [];

    page.addAll(header!.map((Widget e) => e));
    page.add(SizedBox(height: marginBodyTop));
    page.addAll(body!.map((Widget item) => item));
    page.add(SizedBox(height: marginBodyBottom));
    page.addAll(actions!.map((Widget item) => item));

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

abstract class _SimplePageCustomElement extends StatelessWidget {
  const _SimplePageCustomElement({super.key});
}

abstract class SimplePageTemplateHeader extends _SimplePageCustomElement {
  const SimplePageTemplateHeader({super.key});
}

abstract class SimplePageTemplateBody extends _SimplePageCustomElement {
  const SimplePageTemplateBody({super.key});
}

abstract class SimplePageTemplateActions extends _SimplePageCustomElement {
  const SimplePageTemplateActions({super.key});
}

abstract class SimplePageITSHeader extends SimplePageTemplateHeader {
  final ImageProvider image;
  final String title;
  final String subTitle;
  final double imageMargin;
  final double titleMargin;

  const SimplePageITSHeader({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.imageMargin,
    required this.titleMargin,
  });
}

abstract class SimplePageTBActions extends SimplePageTemplateActions {
  final ButtonStyleButton firstAction;
  final ButtonStyleButton secondAction;
  final List<Widget>? extraActions;
  final bool isFlexibleWrap;
  final int firstFlex;
  final int secondFlex;
  final double spacing;
  final Axis direction;
  final bool isExtraAfter;
  final VerticalDirection verticalDirection;

  const SimplePageTBActions({
    super.key,
    required this.firstAction,
    required this.secondAction,
    required this.direction,
    this.extraActions,
    this.isExtraAfter = true,
    this.spacing = 15,
    this.firstFlex = 1,
    this.secondFlex = 1,
    this.isFlexibleWrap = false,
    this.verticalDirection = VerticalDirection.down,
  });

  Widget _createWrapper(action, {required flex}) {
    return Flexible(child: action, flex: flex);
  }

  Widget _createActions() {
    return Flex(
      direction: direction,
      verticalDirection: verticalDirection,
      children: [
        isFlexibleWrap
            ? _createWrapper(firstAction, flex: firstFlex)
            : firstAction,
        SizedBox(
          height: direction == Axis.vertical ? spacing : 0,
          width: direction == Axis.horizontal ? spacing : 0,
        ),
        isFlexibleWrap
            ? _createWrapper(secondAction, flex: secondFlex)
            : secondAction,
      ],
    );
  }

  Widget _createWithExtraActions() {
    if (extraActions == null) {
      return _createActions();
    }

    List<Widget> actions = [];
    if (isExtraAfter) {
      actions.add(_createActions());
      actions.addAll(extraActions!.map((Widget e) => e));
    } else {
      actions.addAll(extraActions!.map((Widget e) => e));
      actions.add(_createActions());
    }

    return Column(
      children: actions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createWithExtraActions();
  }
}
