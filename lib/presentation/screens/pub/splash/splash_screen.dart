import 'package:check_bond/presentation/providers/providers/splash_provider.dart';
import 'package:check_bond/presentation/providers/states/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infra/configs/config_exports.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SplashState>(splashProvider, (previous, next) {
      if (!next.isLoggedIn) {
        Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.landingRoute);
      }
    });

    ref.read(splashProvider.notifier).checkLoginStatus();
    return Scaffold(
            body: Stack(children: [
              // Container(child: Image.asset(AppImages.app_bg)),
              Center(
                child:
                Container(width: 150, child: Image.asset(AppImages.logo)),
              ),
            ])

    );
  }
}
