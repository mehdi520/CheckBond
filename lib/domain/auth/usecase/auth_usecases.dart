
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/user/req_model/pass_change_req_model.dart';
import 'package:check_bond/data/models/user/req_model/update_profile_req_model.dart';
import 'package:check_bond/domain/auth/contracts/auth_repository.dart';
import 'package:dartz/dartz.dart';


class AuthUsecases {
  final AuthRepository _repository;

  AuthUsecases(this._repository);

  Future<Either> signin(SignUpReqModel req) async {
    return await _repository.signin(req);
  }

  Future<Either> signup(SignUpReqModel req) async {
    return await _repository.signup(req);
  }

  Future<Either> updateProfile({UpdateProfileReqModel? params}) async{
    return await _repository.updateProfile(params!);
  }
  Future<Either> changePass({PassChangeReqModel? params}) async{
    return await _repository.changePass(params!);
  }
}