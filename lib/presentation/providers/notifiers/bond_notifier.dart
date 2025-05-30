import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:check_bond/domain/bond/usecase/bond_usecases.dart';
import 'package:check_bond/presentation/providers/states/bond_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/utils/utils_exports.dart';

class BondNotifier extends StateNotifier<BondState> {
  final BondUsecases _usecases;

  BondNotifier(this._usecases) : super(const BondState());

  Future<void> getBondTypes() async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      apiIdentifier: 'getBondTypes',
    );
    try {
      final Either returnedData = await _usecases.getBondTypes();
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            apiIdentifier: 'getBondTypes',
          );
        },
        (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: null,
            bondTypes: data.data,
            apiIdentifier: 'getBondTypes',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'getBondTypes',
      );
    }
  }

  Future<void> getDrawsByType(int bondTypeId) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      apiIdentifier: 'getDrawsByType',
    );
    try {
      final Either returnedData = await _usecases.getDrawsByType(bondTypeId);
      returnedData.fold(
            (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            apiIdentifier: 'getDrawsByType',
          );
        },
            (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: null,
            draws: data.data,
            apiIdentifier: 'getDrawsByType',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'getDrawsByType',
      );
    }
  }

  Future<void> addUpdateDrawsByBondType(DrawDataModel req) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      apiIdentifier: 'addUpdateDrawsByBondType',
    );
    try {
      final Either returnedData = await _usecases.addUpdateDrawsByBondType(req);
      returnedData.fold(
            (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            apiIdentifier: 'addUpdateDrawsByBondType',
          );
        },
            (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: data,
            apiIdentifier: 'addUpdateDrawsByBondType',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'addUpdateDrawsByBondType',
      );
    }
  }

}
