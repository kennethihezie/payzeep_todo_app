import 'package:flutter/material.dart';
import 'package:todo_app/common/extensions/extensions.dart';
import 'package:todo_app/common/theme/color/app_colors.dart';
import 'package:todo_app/common/theme/size_config.dart';
import 'package:todo_app/common/theme/typography/text_styles.dart';

class _CardWithTitle extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final String? title;
  final String? optionalText;
  final TextStyle? titleStyle;
  final TextStyle? optionalTextStyle;
  final double borderRadius;

  const _CardWithTitle({
    super.key,
    this.child,
    this.color,
    this.title,
    this.optionalText,
    this.titleStyle,
    this.optionalTextStyle,
    this.borderRadius = 4
  });

  @override
  Widget build(BuildContext context) {
    // final colorProvider = ColorProvider.of(context);
    final container = _AppContainer.elevation0(
      key: key,
      borderRadius: borderRadius,
      color: color,
      child: child,
    );

    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != null || optionalText != null) Row(
          children: [
            Text(
              title ?? "",
              style: titleStyle ?? AppTextStyle.body.largeMedium
                  .copyWith(color: AppColors.cardTitleColor),
            ),
            4.horizontalGap,
            Text(
              optionalText ?? "",
              style: optionalTextStyle ?? AppTextStyle.body.small
                  .copyWith(color: AppColors.cardTitleColor),
            ),
          ],
        ),
        if(title != null ) const SizedBox(
          height: 8,
        ),
        container
      ],
    );
  }
}

class AppCards {
  const AppCards._();

  static Widget withTitle({
    Key? key,
    Widget? child,
    Color? color,
    String? title,
    String? optionalText,
    TextStyle? titleStyle,
    TextStyle? optionalTextStyle,
    double borderRadius = 4,
  }) {
    return _CardWithTitle(
      key: key,
      color: color,
      title:  title,
      optionalText: optionalText,
      titleStyle: titleStyle,
      optionalTextStyle: optionalTextStyle,
      borderRadius: borderRadius,
      child: child,
    );
  }
}

class _AppContainer extends StatelessWidget {
  const _AppContainer(
      {super.key, this.child, this.color, this.borderRadius = 4, this.border});

  const factory _AppContainer.elevation0(
      {Key? key,
        Widget? child,
        Color? color,
        double borderRadius,
        Border? border}) = _Elevation0;

  final Widget? child;
  final Color? color;
  final double borderRadius;
  final Border? border;

  BoxShape get shape => BoxShape.rectangle;

  Widget buildContainer({
    required BuildContext context,
    Color? color,
    List<BoxShadow> boxShadow = const [],
  }) {
    // final colorProvider = ColorProvider.of(context);
    final backgroundColor = this.color ?? color ?? AppColors.backgroundDefault;

    final radius = shape == BoxShape.circle
        ? null
        : BorderRadius.circular(SizeConfig.radius(borderRadius));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: radius,
          shape: shape,
          boxShadow: boxShadow,
          border: border),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        shape: shape == BoxShape.circle ? const CircleBorder() : null,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(context: context);
  }
}

class _Elevation0 extends _AppContainer {
  const _Elevation0(
      {super.key, super.child, super.color, super.borderRadius, super.border});
}

