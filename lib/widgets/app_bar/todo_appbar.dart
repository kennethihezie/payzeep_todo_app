import 'package:flutter/material.dart';
import 'package:todo_app/common/theme/size_config.dart';
import 'package:todo_app/common/theme/typography/text_styles.dart';


class TodoAppBar {
  TodoAppBar._();

  static PreferredSizeWidget primary({
    required String title,
    List<Widget> actions = const [],
    bool automaticallyImpliesLeading = true,
    double elevation = 0.0,
  }) {
    return _AppPrimaryAppBar(
      title: title,
      actions: actions,
      automaticallyImpliesLeading: automaticallyImpliesLeading,
      elevation: elevation,
    );
  }
}


class _AppPrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final String title;
  final bool automaticallyImpliesLeading;
  final double elevation;

  const _AppPrimaryAppBar({
    required this.actions,
    required this.title,
    required this.automaticallyImpliesLeading,
    this.elevation = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return _$AppBar(
      title: title,
      actions: actions,
      centerTitle: false,
      elevation: elevation,
      automaticallyImpliesLeading: automaticallyImpliesLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class _$AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool automaticallyImpliesLeading;
  final Widget? icon;
  final PreferredSize? bottom;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;

  const _$AppBar({
    this.title,
    this.automaticallyImpliesLeading = true,
    this.icon,
    this.actions,
    this.bottom,
    this.centerTitle = true,
    this.elevation = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      title: Text(
        title ?? '',
        style: AppTextStyle.body.largeSemiBold.copyWith(fontSize: 20, height: 24.0.toLineHeight(16)),
      ),
      automaticallyImplyLeading: automaticallyImpliesLeading,
      actions: actions,
      centerTitle: centerTitle,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

