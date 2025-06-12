import 'package:check_bond/data/models/auth_models/response_model/login/login_res_model.dart';
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/analyze_res_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/get_draw_result_res_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/get_draws_by_type_res_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/get_user_bond_summary_res_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/get_user_bonds_res_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/get_won_bounds_res_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:check_bond/data/models/user/req_model/pass_change_req_model.dart';
import 'package:check_bond/data/models/user/req_model/update_profile_req_model.dart';
import 'package:check_bond/data/models/user/response_model/get_profile_res_model.dart';
import 'package:check_bond/infra/configs/constants/constants.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/bonds/resp_model/get_bond_types_res_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: APIBaseURL)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST('api/pub/Register')
  Future<HttpResponse<BaseResponseModel>> signup({
    @Body() required SignUpReqModel req,
  });

  @POST('api/pub/login')
  Future<HttpResponse<LoginResModel>> signin({
    @Body() required SignUpReqModel req,
  });

  @GET('api/User/GetProfile')
  Future<HttpResponse<GetProfileResModel>> getProfile();

  @POST('api/user/updateProfile')
  Future<HttpResponse<BaseResponseModel>> updateProfile({
    @Body() required UpdateProfileReqModel req,
  });

  @POST('api/user/changepass')
  Future<HttpResponse<BaseResponseModel>> changePass({
    @Body() required PassChangeReqModel req,
  });

  @GET('api/bonds/GetBondTypes')
  Future<HttpResponse<GetBondTypesResModel>> GetBondTypes();

  @GET('api/bonds/GetDrawsByBondType')
  Future<HttpResponse<GetDrawsByTypeResModel>> GetDrawsByType({
    @Query('bondType') required int bondType
  });

  @POST('api/bonds/AddUpdateDrawsByBondType')
  Future<HttpResponse<BaseResponseModel>> AddUpdateDrawsByBondType({
    @Body() required DrawDataModel req
  });

  @POST('api/bonds/AnalyzeUploadNewDrawResult')
  Future<HttpResponse<AnalyzeResModel>> AnalyzeUploadNewDrawResult({
    @Body() required FormData formData,
  });

  @GET('api/bonds/ImportDrawResult')
  Future<HttpResponse<BaseResponseModel>> ImportDrawResult({
   @Query('id') required int id
  });

  @GET('api/bonds/GetDrawResult')
  Future<HttpResponse<GetDrawResultResModel>> GetDrawResult({
    @Query('id') required int id
  });

  @GET('api/bonds/GetUserBonds')
  Future<HttpResponse<GetUserBondsResModel>> GetUserBonds({
    @Query('typeId') required int typeId
  });

  @POST('api/bonds/AddUpdateUserBond')
  Future<HttpResponse<BaseResponseModel>> AddupdateUseBonds({
    @Body() required UserBondDataModel req
  });


  @GET('api/bonds/DeleteUserBond')
  Future<HttpResponse<BaseResponseModel>> DelUserBonds({
    @Query('bondId') required int bondId
  });

  @GET('api/bonds/DrawWinCheckSyncByDraw')
  Future<HttpResponse<BaseResponseModel>> DrawWinCheckSyncByDraw({
    @Query('drawId') required int drawId
  });

  @GET('api/bonds/GetUserWonBonds')
  Future<HttpResponse<GetWonBoundsResModel>> GetUserWonBonds({
    @Query('status') required String status
  });

  @GET('api/bonds/UpdateUserWonBondStatus')
  Future<HttpResponse<BaseResponseModel>> UpdateUserWonBondStatus({
    @Query('status') required String status,
    @Query('wonId') required int wonId
  });

  @GET('api/bonds/GetUserBondsSummary')
  Future<HttpResponse<GetUserBondSummaryResModel>> GetUserBondsSummary();


}
