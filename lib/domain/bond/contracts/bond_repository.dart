
import 'package:check_bond/data/models/auth_models/sign_up_req_model.dart';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:dartz/dartz.dart';

abstract class BondRepository {
  Future<Either> getBondTypes();
  Future<Either> getDrawsByType(int bondType);
  Future<Either> addUpdateDrawsByBondType(DrawDataModel req);

}