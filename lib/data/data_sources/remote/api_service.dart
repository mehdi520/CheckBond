import 'package:check_bond/data/models/auth_models/response_model/login/login_res_model.dart';
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/bonds/resp_model/get_sch_bonds_by_year_res_model.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:check_bond/data/models/user/req_model/pass_change_req_model.dart';
import 'package:check_bond/data/models/user/req_model/update_profile_req_model.dart';
import 'package:check_bond/data/models/user/response_model/get_profile_res_model.dart';
import 'package:check_bond/infra/configs/constants/constants.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/bonds/resp_model/get_records_avail_years_res_model.dart';

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

  @GET('api/bonds/GetRecordsAvailableYears')
  Future<HttpResponse<GetRecordsAvailYearsResModel>> GetRecordsAvailableYears();

  @GET('api/bonds/GetScheduleDrawByYear')
  Future<HttpResponse<GetSchBondsByYearResModel>> GetScheduleBondByYear({
    @Query('yearId') required int yearId
  });

}
