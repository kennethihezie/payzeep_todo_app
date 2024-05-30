
import 'package:flutter/material.dart';
import 'body_text_style.dart';

typedef HealthBubbaTextStyleBuilder = TextStyle Function(BuildContext context);

class AppTextStyle {
  const AppTextStyle._();

  static TextBodyStyle get body => TextBodyStyle();
}
