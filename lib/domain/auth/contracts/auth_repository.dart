
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(SignUpReqModel req);
  Future<Either> signin(SignUpReqModel req);
  Future<Either> getProfile();
}