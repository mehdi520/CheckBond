import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:check_bond/domain/auth/contracts/auth_repository.dart';
import 'package:check_bond/domain/bond/contracts/bond_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BondUsecases {
  final BondRepository _repository;

  BondUsecases(this._repository);

  Future<Either> getBondTypes() async {
    return await _repository.getBondTypes();
  }

  Future<Either> getDrawsByType(int bondType) async {
    return await _repository.getDrawsByType(bondType);
  }

  Future<Either> addUpdateDrawsByBondType(DrawDataModel req) async {
    return await _repository.addUpdateDrawsByBondType(req);
  }

  Future<Either> analyzeDrawUpload(FormData req) async {
    return await _repository.analyzeDrawUpload(req);
  }

  Future<Either> importDrawResult(int id) async {
    return await _repository.importDrawResult(id);
  }

  Future<Either> getDrawResult(int id) async {
    return await _repository.getDrawResult(id);
  }

  Future<Either> GetUserBonds(int typeId) async {
    return await _repository.GetUserBonds(typeId);
  }

  Future<Either> AddupdateUseBonds(UserBondDataModel req) async {
    return await _repository.AddupdateUseBonds(req);
  }

  Future<Either> DelUserBonds(int bondId) async {
    return await _repository.DelUserBonds(bondId);
  }

  Future<Either> DrawWinCheckSyncByDraw(int drawId)async {
    return await _repository.DrawWinCheckSyncByDraw(drawId);
  }

  Future<Either> GetUserWonBonds(String status)async {
    return await _repository.GetUserWonBonds(status);
  }
  Future<Either> UpdateUserWonBondStatus(String status, int wonId)async {
    return await _repository.UpdateUserWonBondStatus(status,wonId);
  }

}
