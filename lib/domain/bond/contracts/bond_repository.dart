
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:dartz/dartz.dart';

abstract class BondRepository {
  Future<Either> getRecordsAvailableYears();
  Future<Either> getSchBondsByYear(int yearId);
}