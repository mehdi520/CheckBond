import 'package:check_bond/domain/auth/usecase/auth_usecases.dart';
import 'package:check_bond/presentation/providers/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/auth_models/response_model/login/login_res_model.dart';
import 'package:check_bond/infra/utils/utils_exports.dart';
import 'package:dartz/dartz.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthUsecases _authUsecases;
  AuthNotifier(this._authUsecases) : super(const AuthState());

  Future<void> signin(SignUpReqModel req) async {
    state = state.copyWith(apiStatus: ApiStatus.loading);
    try {
      final Either returnedData = await _authUsecases.signin(req);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: LoginResModel(status: false, message: error.message),
          );
        },
        (data) {
          state = state.copyWith(apiStatus: ApiStatus.success, resp: data);
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: LoginResModel(status: false, message: e.toString()),
      );
    }
  }

  Future<void> signup(SignUpReqModel req) async {
    state = state.copyWith(apiStatus: ApiStatus.loading);
    try {
      final Either returnedData = await _authUsecases.signup(req);
      returnedData.fold(
        (error) {
          print(error);
          state = state.copyWith(
            apiStatus: ApiStatus.error,
            resp: LoginResModel(status: false, message: error.message),
          );
        },
        (data) {
          state = state.copyWith(apiStatus: ApiStatus.success, resp: data);
        },
      );
    } catch (e) {
      state = state.copyWith(
        apiStatus: ApiStatus.error,
        resp: LoginResModel(status: false, message: e.toString()),
      );
    }
  }
}