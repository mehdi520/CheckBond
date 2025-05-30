
import 'package:check_bond/presentation/providers/notifiers/splash_notifier.dart';
import 'package:check_bond/presentation/providers/states/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = StateNotifierProvider<SplashNotifier,SplashState>((ref) => SplashNotifier());