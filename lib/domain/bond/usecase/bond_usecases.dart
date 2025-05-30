
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/domain/auth/contracts/auth_repository.dart';
import 'package:check_bond/domain/bond/contracts/bond_repository.dart';
import 'package:dartz/dartz.dart';


class BondUsecases {
  final BondRepository _repository;

  BondUsecases(this._repository);

  Future<Either> getBondTypes() async {
    return await _repository.getBondTypes();
  }

  Future<Either> getDrawsByType(int bondType) async {
    return await _repository.getDrawsByType(bondType);
  }
  Future<Either> addUpdateDrawsByBondType(DrawDataModel req) async
  {
    return await _repository.addUpdateDrawsByBondType(req);

  }


}