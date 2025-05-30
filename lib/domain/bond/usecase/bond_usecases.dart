
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/domain/auth/contracts/auth_repository.dart';
import 'package:check_bond/domain/bond/contracts/bond_repository.dart';
import 'package:dartz/dartz.dart';


class BondUsecases {
  final BondRepository _repository;

  BondUsecases(this._repository);

  Future<Either> getRecordsAvailableYears() async {
    return await _repository.getRecordsAvailableYears();
  }

  Future<Either> getSchBondsByYear(int yearId) async {
    return await _repository.getSchBondsByYear(yearId);
  }



}