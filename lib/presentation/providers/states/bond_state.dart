import 'package:check_bond/data/models/bonds/data_model/record_avail_year_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/sch_bond_data_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';

import '../../../infra/utils/utils_exports.dart';

class BondState {
  final ApiStatus apiStatus;
  final BaseResponseModel? resp;
  final String? apiIdentifier;
  final List<RecordAvailYearDataModel> dataYears;
  final List<SchBondDataModel> schBonds;

  const BondState({this.apiStatus = ApiStatus.initial,this.apiIdentifier = null,this.resp = null ,
    this.dataYears = const[],
    this.schBonds = const[]
  });

  BondState copyWith({
    ApiStatus? apiStatus,
    BaseResponseModel? resp,
    String? apiIdentifier,
    List<RecordAvailYearDataModel>? dataYears,
    List<SchBondDataModel>? schBonds
  }) {
    return BondState(
        apiIdentifier: apiIdentifier ?? this.apiIdentifier,
        apiStatus: apiStatus ?? this.apiStatus,
        resp: resp ?? this.resp,
        dataYears: dataYears ?? this.dataYears,
        schBonds : schBonds ?? this.schBonds
    );
  }
}
