import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:check_bond/domain/bond/usecase/bond_usecases.dart';
import 'package:check_bond/presentation/providers/states/bond_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/utils/utils_exports.dart';

class BondNotifier extends StateNotifier<BondState> {
  final BondUsecases _usecases;

  BondNotifier(this._usecases) : super(const BondState());

  Future<void> getRecordsAvailableYears() async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      apiIdentifier: 'getRecordsAvailableYears',
    );
    try {
      final Either returnedData = await _usecases.getRecordsAvailableYears();
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            apiIdentifier: 'getRecordsAvailableYears',
          );
        },
        (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: null,
            dataYears: data.data,
            apiIdentifier: 'getRecordsAvailableYears',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'getRecordsAvailableYears',
      );
    }
  }

  Future<void> getSchBondsByYear(int yearId) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      apiIdentifier: 'getSchBondsByYear',
    );
    try {
      final Either returnedData = await _usecases.getSchBondsByYear(yearId);
      returnedData.fold(
            (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            apiIdentifier: 'getSchBondsByYear',
          );
        },
            (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: null,
            schBonds: data.data,
            apiIdentifier: 'getSchBondsByYear',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'getSchBondsByYear',
      );
    }
  }

}
