import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/modules/app/app.dart';
import 'common/di/di.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpLocator();

  runApp(const ProviderScope(child: App()));
}