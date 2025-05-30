import 'package:check_bond/domain/bond/usecase/bond_usecases.dart';
import 'package:check_bond/presentation/providers/notifiers/bond_notifier.dart';
import 'package:check_bond/presentation/providers/states/bond_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/di/service_locator.dart';

final bondProvider = StateNotifierProvider<BondNotifier,BondState>((ref) => BondNotifier(sl<BondUsecases>()));