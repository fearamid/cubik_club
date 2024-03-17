import 'package:cubik_club/common/widgets/simple_page_template.dart';
import 'package:flutter/material.dart';

class _AuthPageHeader extends SimplePageITSHeader {
  const _AuthPageHeader({
    required super.image,
    required super.title,
    required super.subTitle,
    super.imageMargin = 13,
    super.titleMargin = 5,
    // super.verticalDirection = VerticalDirection.up,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          alignment: Alignment.center,
          width: double.infinity,
          height: 200,
          image: image,
        ),
        SizedBox(height: imageMargin),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: titleMargin),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _AuthPageActions extends SimplePageTBActions {
  const _AuthPageActions({
    required super.firstAction,
    required super.secondAction,
    required super.direction,
    required super.isExtraAfter,
    required super.isFlexibleWrap,
    required super.extraActions,
    super.verticalDirection = VerticalDirection.up,
  });
}

// ignore: must_be_immutable
class AuthPageTemplate extends SimplePageTemplate {
  AuthPageTemplate({
    super.key,
    required image,
    required title,
    required subTitle,
    required super.body,
    required VoidCallback? onFirstPressed,
    required VoidCallback? onSecondPressed,
    super.marginBodyTop = 30,
    super.marginBodyBottom = 60,
    List<Widget>? extraActions,
    bool isExtraAfter = true,
    bool isActionsHorizontal = true,
    String firstActionTitle = 'Назад',
    String secondActionTitle = 'Вперед',
  }) : super.withoutBody(
          customHeader: _AuthPageHeader(
            image: AssetImage(image),
            title: title,
            subTitle: subTitle,
          ),
          customActions: _AuthPageActions(
            isExtraAfter: isExtraAfter,
            extraActions: extraActions,
            isFlexibleWrap: isActionsHorizontal,
            firstAction: OutlinedButton(
              onPressed: onFirstPressed,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Text(firstActionTitle, textAlign: TextAlign.center),
              ),
            ),
            secondAction: ElevatedButton(
              onPressed: onSecondPressed,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Text(secondActionTitle, textAlign: TextAlign.center),
              ),
            ),
            direction: isActionsHorizontal ? Axis.horizontal : Axis.vertical,
          ),
        );
}
