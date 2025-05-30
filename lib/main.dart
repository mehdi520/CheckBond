import 'package:check_bond/infra/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'infra/configs/config_exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializedDepencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashRoute,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
