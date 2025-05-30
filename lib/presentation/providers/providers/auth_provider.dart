
import 'package:check_bond/domain/auth/usecase/auth_usecases.dart';
import 'package:check_bond/infra/di/service_locator.dart';
import 'package:check_bond/presentation/providers/notifiers/auth_notifier.dart';
import 'package:check_bond/presentation/providers/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier,AuthState>((ref) => AuthNotifier(sl<AuthUsecases>()));