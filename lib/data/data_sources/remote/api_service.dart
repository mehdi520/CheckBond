import 'package:check_bond/data/models/auth_models/response_model/login/login_res_model.dart';
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/get_draws_by_type_res_model.dart';
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

}
