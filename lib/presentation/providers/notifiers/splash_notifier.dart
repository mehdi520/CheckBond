import 'package:check_bond/data/data_sources/local/hive_manager.dart';
import 'package:check_bond/presentation/providers/states/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  SplashNotifier() : super(const SplashState());

  void checkLoginStatus() async{
    await Future.delayed(const Duration(seconds: 2));
    final token = HiveManager.getToken();
    if (token == null || token.isEmpty) {
      state = state.copyWith(isLoggedIn: false);
    } else {
      print("token is $token");
      state = state.copyWith(isLoggedIn: true);
    }
  }

}