import 'package:check_bond/data/models/bonds/data_model/bond_type_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';

import '../../../infra/utils/utils_exports.dart';

class BondState {
  final ApiStatus apiStatus;
  final BaseResponseModel? resp;
  final String? apiIdentifier;
  final List<BondTypeDataModel> bondTypes;
  final List<DrawDataModel> draws;

  const BondState({this.apiStatus = ApiStatus.initial,this.apiIdentifier = null,this.resp = null ,
    this.bondTypes = const[],
    this.draws = const[]
  });

  BondState copyWith({
    ApiStatus? apiStatus,
    BaseResponseModel? resp,
    String? apiIdentifier,
    List<BondTypeDataModel>? bondTypes,
    List<DrawDataModel>? draws
  }) {
    return BondState(
        apiIdentifier: apiIdentifier ?? this.apiIdentifier,
        apiStatus: apiStatus ?? this.apiStatus,
        resp: resp ?? this.resp,
        bondTypes: bondTypes ?? this.bondTypes,
        draws : draws ?? this.draws
    );
  }
}
