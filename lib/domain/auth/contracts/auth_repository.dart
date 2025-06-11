
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/user/req_model/pass_change_req_model.dart';
import 'package:check_bond/data/models/user/req_model/update_profile_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(SignUpReqModel req);
  Future<Either> signin(SignUpReqModel req);
  Future<Either> getProfile();
  Future<Either> updateProfile(UpdateProfileReqModel req);
  Future<Either> changePass(PassChangeReqModel req);
}