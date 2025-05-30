
import 'package:check_bond/data/models/common_models/base_response_model.dart';

import '../../../infra/utils/utils_exports.dart';

class AuthState {
  final ApiStatus apiStatus;
  final BaseResponseModel? resp;
  final String? apiIdentifier;

  const AuthState({this.apiStatus = ApiStatus.initial,this.apiIdentifier = null,this.resp = null});

  AuthState copyWith({
    ApiStatus? apiStatus,
    BaseResponseModel? resp,
    String? apiIdentifier}) {
    return AuthState(
      apiIdentifier: apiIdentifier ?? this.apiIdentifier,
      apiStatus: apiStatus ?? this.apiStatus,
      resp: resp ?? this.resp
    );
  }
}
