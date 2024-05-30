import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



extension BuildContextEx on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  GoRouter get router => GoRouter.of(this);

  bool get isSmallDevice => mediaQuery.size.width < 380;
}

extension GoRouterEx on GoRouter {
  void popUntilPath(BuildContext context, String ancestorPath) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        ancestorPath) {
      if (!context.canPop()) {
        return;
      }
      context.pop();
    }
  }
}


extension Gap on num {
  Widget get verticalGap => SizedBox(
        height: toDouble(),
      );

  Widget get horizontalGap => SizedBox(
        width: toDouble(),
      );
}

extension StringEx on String? {
  String get orEmpty => this ?? "";

  bool get isEmail {
    final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailPattern.hasMatch(this ?? '');
  }

  String get cleanPhoneNumberForInput {
    if (this == null) return '';
    return '0${this?.replaceAll(RegExp(r'[^\d]'), '')}';
  }
}

extension WeekDaysEx on int {
  String get shortWeekDay {
    const List<String> shortWeekdays = <String>[
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
    return shortWeekdays[this];
  }

  String get month {
    const List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'Septemper',
      'October',
      'November',
      'December',
    ];
    return months[this];
  }

  String get nth {
    if (this >= 11 && this <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

extension BoolEx on bool? {
  bool get isTrue => this == true;

  bool get isFalse => this == false;

  bool get orFalse => this ?? false;
}
