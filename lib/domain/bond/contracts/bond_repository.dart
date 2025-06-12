
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BondRepository {
  Future<Either> getBondTypes();
  Future<Either> getDrawsByType(int bondType);
  Future<Either> addUpdateDrawsByBondType(DrawDataModel req);
  Future<Either> analyzeDrawUpload(FormData req);
  Future<Either> importDrawResult(int id);
  Future<Either> getDrawResult(int id);

  Future<Either> GetUserBonds(int typeId);
  Future<Either> AddupdateUseBonds(UserBondDataModel req);
  Future<Either> DelUserBonds(int bondId);
  Future<Either> DrawWinCheckSyncByDraw(int drawId);
  Future<Either> GetUserWonBonds(String status);
  Future<Either> UpdateUserWonBondStatus(String status, int wonId);
  Future<Either> GetUserBondsSummary();

}