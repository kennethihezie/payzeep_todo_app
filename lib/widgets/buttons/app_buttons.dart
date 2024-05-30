import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/common/extensions/extensions.dart';
import 'package:todo_app/common/theme/color/app_colors.dart';
import 'package:todo_app/common/theme/size_config.dart';
import 'package:todo_app/common/theme/typography/text_styles.dart';

enum IconAlignment {
  left,
  right,
}

sealed class AppButton extends StatelessWidget {
  const AppButton({super.key});

  factory AppButton.primary(
      {required String title,
        required void Function() onTap,
        Color? backgroundColor,
        Color? borderColor,
        Color? textColor,
        EdgeInsets? padding,
        ValueNotifier<bool>? state,
        bool isLoading = false,
        bool isExpanded = true}) =>
      _AppButtonPrimary(
          title: title,
          onTap: onTap,
          textColor: textColor,
          backgroundColor: backgroundColor,
          padding: padding,
          state: state,
          borderColor: borderColor,
          isLoading: isLoading,
          isExpanded: isExpanded);
}

class _AppButtonPrimary extends StatelessWidget implements AppButton {
  final String title;
  final void Function() onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final ValueNotifier<bool>? state;
  final bool isLoading;
  final bool isExpanded;

  const _AppButtonPrimary(
      {required this.title,
        required this.onTap,
        this.backgroundColor,
        this.textColor,
        this.padding,
        this.borderColor,
        required this.state,
        required this.isLoading,
        this.isExpanded = true,
        super.key});

  @override
  Widget build(BuildContext context) {
    return _$AppButton(
      title: title,
      onTap: onTap,
      textColor: textColor,
      padding: padding,
      state: state,
      borderColor: borderColor ?? AppColors.primaryBorder,
      isLoading: isLoading,
      isExpanded: isExpanded,
      backgroundColor: backgroundColor ?? AppColors.primaryGreen,
    );
  }
}


class _$AppButton extends AppButton {
  final String title;
  final void Function() onTap;
  final Widget? icon;
  final ValueNotifier<bool>? state;
  final bool isLoading;
  final IconAlignment iconAlignment;
  final Color backgroundColor;
  final Color? textColor;
  final Color borderColor;
  final EdgeInsets? padding;
  final bool isFilled;
  final bool isExpanded;

  const _$AppButton(
      {required this.title,
        required this.onTap,
        this.icon,
        this.iconAlignment = IconAlignment.left,
        this.backgroundColor = AppColors.primaryGreen,
        this.textColor,
        this.padding,
        this.borderColor = AppColors.primaryBorder,
        required this.state,
        required this.isLoading,
        this.isFilled = true,
        this.isExpanded = true,
        super.key});

  @override
  Widget build(BuildContext context) {
    const effectivePadding = EdgeInsets.symmetric(vertical: 16, horizontal: 16);

    Widget iconLeftAlignedAndText() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const SizedBox.shrink(),
          8.horizontalGap,
          Text(
            title,
            style:
            AppTextStyle.body.largeMedium.copyWith(color: textColor),
          ),
        ],
      );
    }

    Widget iconRightAlignedAndText() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.body.largeMedium.copyWith(color: textColor),
          ),
          8.horizontalGap,
          icon ?? const SizedBox.shrink(),
        ],
      );
    }


    Widget filledButton = ValueListenableBuilder(
        valueListenable: state ?? ValueNotifier<bool>(true),
        builder: (context, state, child) {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                padding: padding ?? effectivePadding,
                shadowColor: AppColors.transparent,
                minimumSize: Size(isExpanded ? double.infinity : 0, 50),
                backgroundColor: backgroundColor,
                disabledBackgroundColor: AppColors.grey,//backgroundColor.withOpacity(0.3),
                disabledForegroundColor: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(color: state ? borderColor : AppColors.greyBorder, width: 2) ,borderRadius: BorderRadius.circular(100)),
                foregroundColor: textColor ?? AppColors.white,
              ),
              onPressed: (!state || isLoading) ? null : onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    iconAlignment == IconAlignment.left
                        ? iconLeftAlignedAndText()
                        : iconRightAlignedAndText()
                  else
                    Text(
                      title,
                      style: AppTextStyle.body.largeMedium.copyWith(
                          color: state ? textColor : AppColors.textGrey, height: 14.0.toLineHeight(14)),
                    )
                ],
              ));
        });

    return filledButton;
  }
}
