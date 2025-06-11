import 'package:check_bond/data/models/bonds/data_model/analyzed_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/bond_type_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_details_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/won_bond_data_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/analyze_res_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';

import '../../../infra/utils/utils_exports.dart';

class BondState {
  final ApiStatus apiStatus;
  final BaseResponseModel? resp;
  final String? apiIdentifier;
  final List<BondTypeDataModel> bondTypes;
  final List<DrawDataModel> draws;
  final AnalyzeResModel? analyzeResult;
  final DrawDetailsDataModel? drawResult;
  final List<UserBondDataModel> userBonds;
  final List<WonBondDataModel> userWonBonds;

  const BondState({
    this.apiStatus = ApiStatus.initial,
    this.apiIdentifier = null,
    this.resp = null,
    this.bondTypes = const [],
    this.draws = const [],
    this.analyzeResult = null,
    this.drawResult = null,
    this.userBonds = const [],
    this.userWonBonds = const [],
  });

  BondState copyWith({
    ApiStatus? apiStatus,
    BaseResponseModel? resp,
    String? apiIdentifier,
    List<BondTypeDataModel>? bondTypes,
    List<DrawDataModel>? draws,
    AnalyzeResModel? analyzeResult,
    DrawDetailsDataModel? drawResult,
    List<UserBondDataModel>? userBonds,
    List<WonBondDataModel>? userWonBonds,
  }) {
    return BondState(
      apiIdentifier: apiIdentifier ?? this.apiIdentifier,
      apiStatus: apiStatus ?? this.apiStatus,
      resp: resp ?? this.resp,
      bondTypes: bondTypes ?? this.bondTypes,
      draws: draws ?? this.draws,
      analyzeResult: analyzeResult ?? this.analyzeResult,
      drawResult: drawResult,
      userBonds: userBonds ?? this.userBonds,
      userWonBonds: userWonBonds ?? this.userWonBonds,
    );
  }
}
