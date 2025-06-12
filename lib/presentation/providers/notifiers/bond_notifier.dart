import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:check_bond/domain/bond/usecase/bond_usecases.dart';
import 'package:check_bond/presentation/providers/states/bond_state.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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

  Future<void> analyzeDrawUpload(FormData req) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      apiIdentifier: 'analyzeDrawUpload',
    );
    try {
      final Either returnedData = await _usecases.analyzeDrawUpload(req);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            apiIdentifier: 'analyzeDrawUpload',
          );
        },
        (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            analyzeResult: data,
            apiIdentifier: 'analyzeDrawUpload',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'analyzeDrawUpload',
      );
    }
  }

  Future<void> importDrawResult(int id) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      apiIdentifier: 'importDrawResult',
    );
    try {
      final Either returnedData = await _usecases.importDrawResult(id);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            apiIdentifier: 'importDrawResult',
          );
        },
        (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: data,
            apiIdentifier: 'importDrawResult',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'importDrawResult',
      );
    }
  }

  Future<void> getDrawResult(int id) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'getDrawResult',
    );
    try {
      final Either returnedData = await _usecases.getDrawResult(id);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'getDrawResult',
          );
        },
        (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            drawResult: data.data,
            apiIdentifier: 'getDrawResult',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'getDrawResult',
      );
    }
  }

  Future<void> getUserBonds(int typeId) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'getUserBonds',
    );
    try {
      final Either returnedData = await _usecases.GetUserBonds(typeId);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'getUserBonds',
          );
        },
        (data) {
          state = state.copyWith(
            apiStatus: ApiStatus.success,
            userBonds: data.data,
            resp: data,
            apiIdentifier: 'getUserBonds',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'getUserBonds',
      );
    }
  }

  Future<void> addUpdateUseBonds(UserBondDataModel req) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'addUpdateUseBonds',
    );
    try {
      final Either returnedData = await _usecases.AddupdateUseBonds(req);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'addUpdateUseBonds',
          );
        },
        (data) {

          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: data,
            apiIdentifier: 'addUpdateUseBonds',
          );
          //
          // final existingData = state.userBonds;
          // if (existingData != null) {
          //   final list = state.userBonds;
          //   final index = list.indexWhere(
          //     (element) => element.bondId == data.bondId,
          //   );
          //   list[index] = data;
          //
          //   state = state.copyWith(
          //     apiStatus: ApiStatus.success,
          //     resp: data,
          //     userBonds: list,
          //     apiIdentifier: 'addUpdateUseBonds',
          //   );
          // }
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'addUpdateUseBonds',
      );
    }
  }

  Future<void> delUserBonds(int bondId) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'delUserBonds',
    );
    try {
      final Either returnedData = await _usecases.DelUserBonds(bondId);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'delUserBonds',
          );
        },
        (data) {
          final existingData = state.userBonds;
          if (existingData != null) {
            final updatedList = List<UserBondDataModel>.from(existingData!)
              ..removeWhere((item) => item.bondId == bondId);
            state = state.copyWith(
              apiStatus: ApiStatus.success,
              userBonds: updatedList,
              resp: data,
              apiIdentifier: 'delUserBonds',
            );
          }
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'delUserBonds',
      );
    }
  }

  Future<void> DrawWinCheckSyncByDraw(int drawId) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'DrawWinCheckSyncByDraw',
    );
    try {
      final Either returnedData = await _usecases.DrawWinCheckSyncByDraw(drawId);
      returnedData.fold(
            (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'DrawWinCheckSyncByDraw',
          );
        },
            (data) {

            state = state.copyWith(
              apiStatus: ApiStatus.success,
              resp: data,
              apiIdentifier: 'DrawWinCheckSyncByDraw',
            );

        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'DrawWinCheckSyncByDraw',
      );
    }
  }

  Future<void> GetUserWonBonds(String status) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'GetUserWonBonds',
    );
    try {
      final Either returnedData = await _usecases.GetUserWonBonds(status);
      returnedData.fold(
            (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'GetUserWonBonds',
          );
        },
            (data) {

          state = state.copyWith(
            apiStatus: ApiStatus.success,
            userWonBonds: data.data,
            apiIdentifier: 'GetUserWonBonds',
          );

        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'GetUserWonBonds',
      );
    }
  }
  Future<void> UpdateUserWonBondStatus(String status,int wonId) async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'UpdateUserWonBondStatus',
    );
    try {
      final Either returnedData = await _usecases.UpdateUserWonBondStatus(status,wonId);
      returnedData.fold(
            (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'UpdateUserWonBondStatus',
          );
        },
            (data) {

          state = state.copyWith(
            apiStatus: ApiStatus.success,
            resp: data,
            apiIdentifier: 'UpdateUserWonBondStatus',
          );

        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'UpdateUserWonBondStatus',
      );
    }
  }

  Future<void> GetUserBondsSummary() async {
    state = state.copyWith(
      apiStatus: ApiStatus.loading,
      drawResult: null,
      apiIdentifier: 'GetUserBondsSummary',
    );
    try {
      final Either returnedData = await _usecases.GetUserBondsSummary();
      returnedData.fold(
            (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: error,
            drawResult: null,
            apiIdentifier: 'GetUserBondsSummary',
          );
        },
            (data) {

          state = state.copyWith(
            apiStatus: ApiStatus.success,
            summaryDataModel: data.data,
            apiIdentifier: 'GetUserBondsSummary',
          );

        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        drawResult: null,
        resp: BaseResponseModel(status: false, message: e.toString()),
        apiIdentifier: 'GetUserBondsSummary',
      );
    }
  }

}
