import 'package:flutter/material.dart';
import 'package:todo_app/common/theme/color/app_colors.dart';

class AppInputScheme {
  AppInputScheme({
    required this.errorColor,
    required this.focusBorderColor,
    required this.textColor,
    required this.backgroundColor,
    required this.focusBackgroundColor,
    required this.disableTextColor,
    required this.affixIconColor,
    required this.iconColor,
    required this.disabledAffixIconColor,
    required this.disabledIconColor,
    required this.dividerColor,
    required this.counterColor,
    required this.bottomSheetInputColor,
    required this.inactiveBorderColor,
    required this.shadowInactiveColor
  });

  static AppInputScheme light() {
    return AppInputScheme(
        errorColor: AppColors.red,
        focusBorderColor: AppColors.primaryGreen,
        textColor: AppColors.black,
        backgroundColor: AppColors.white,
        focusBackgroundColor: AppColors.white,
        disableTextColor: AppColors.grey,
        affixIconColor: AppColors.black,
        disabledAffixIconColor: AppColors.black,
        iconColor: AppColors.black.withOpacity(0.4),
        disabledIconColor: AppColors.black.withOpacity(0.2),
        dividerColor: AppColors.grey,
        counterColor: AppColors.black,
        bottomSheetInputColor: AppColors.grey,
        inactiveBorderColor: AppColors.inactiveBorderColor,
        shadowInactiveColor: AppColors.shadowInactiveColor
    );
  }

  // static IrechargeInputScheme dark() {
  //   return IrechargeInputScheme(
  //       errorColor: IrechargeColors.errorRed,
  //       focusBorderColor: IrechargeColors.primaryGreen,
  //       textColor: IrechargeColors.white,
  //       backgroundColor: IrechargeColors.black.shade700,
  //       focusBackgroundColor: IrechargeColors.black.shade700,
  //       disableTextColor: IrechargeColors.white.withOpacity(0.3),
  //       affixIconColor: IrechargeColors.white.withOpacity(0.6),
  //       disabledAffixIconColor: IrechargeColors.white.withOpacity(0.3),
  //       iconColor: IrechargeColors.white.withOpacity(0.5),
  //       disabledIconColor: IrechargeColors.white.withOpacity(0.3),
  //       dividerColor: IrechargeColors.white.withOpacity(0.1),
  //       counterColor: IrechargeColors.white.withOpacity(0.3),
  //       bottomSheetInputColor: IrechargeColors.white.withOpacity(0.2)
  //   );
  // }

  final Color errorColor;
  final Color focusBorderColor;
  final Color textColor;
  final Color backgroundColor;
  final Color bottomSheetInputColor;
  final Color focusBackgroundColor;
  final Color disableTextColor;
  final Color affixIconColor;
  final Color disabledAffixIconColor;
  final Color iconColor;
  final Color disabledIconColor;
  final Color dividerColor;
  final Color counterColor;
  final Color inactiveBorderColor;
  final Color shadowInactiveColor;


  AppInputScheme copyWith({
    Color? errorColor,
    Color? focusBorderColor,
    Color? textColor,
    Color? backgroundColor,
    Color? focusBackgroundColor,
    Color? disableTextColor,
    Color? affixIconColor,
    Color? disabledAffixIconColor,
    Color? iconColor,
    Color? disabledIconColor,
    Color? dividerColor,
    Color? counterColor,
    Color? bottomSheetInputColor,
    Color? shadowInactiveColor,
    Color? inactiveBorderColor
  }) {
    return AppInputScheme(
        errorColor: errorColor ?? this.errorColor,
        shadowInactiveColor: shadowInactiveColor ?? this.shadowInactiveColor,
        inactiveBorderColor: inactiveBorderColor ?? this.inactiveBorderColor,
        focusBorderColor: focusBorderColor ?? this.focusBorderColor,
        textColor: textColor ?? this.textColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        focusBackgroundColor: focusBackgroundColor ?? this.focusBackgroundColor,
        disableTextColor: disableTextColor ?? this.disableTextColor,
        affixIconColor: affixIconColor ?? this.affixIconColor,
        disabledAffixIconColor:
        disabledAffixIconColor ?? this.disabledAffixIconColor,
        iconColor: iconColor ?? this.iconColor,
        disabledIconColor: disabledIconColor ?? this.disabledIconColor,
        dividerColor: dividerColor ?? this.dividerColor,
        counterColor: counterColor ?? this.counterColor,
        bottomSheetInputColor: bottomSheetInputColor ?? this.bottomSheetInputColor
    );
  }
}
