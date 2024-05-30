import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/di/di.dart';
import 'package:todo_app/common/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});
  static final _router = locator<GoRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      routerConfig: _router,
    );
  }
}