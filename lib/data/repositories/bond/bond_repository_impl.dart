import 'dart:io';

import 'package:check_bond/data/data_sources/remote/api_service.dart';
import 'package:check_bond/data/models/common_models/base_response_model.dart';
import 'package:check_bond/domain/bond/contracts/bond_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BondRepositoryImpl extends BondRepository {
  final ApiService _apiService;

  BondRepositoryImpl(this._apiService);

  @override
  Future<Either> getRecordsAvailableYears() async {
    try {
      final httpResponse = await _apiService.GetRecordsAvailableYears();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print(httpResponse.response);
        if (httpResponse.data.status) {
          return Right(httpResponse.data);

        } else {
          return Left(
              BaseResponseModel(status: false,message: httpResponse.data.message,code: httpResponse.response.statusCode)
          );
        }
      } else {
        print(httpResponse.response);
        return Left(
            BaseResponseModel(status: false,message: httpResponse.data.message,code: httpResponse.response.statusCode)
        );
      }
    } on DioException catch (e) {
      print(e);
      return Left(
          BaseResponseModel(status: false,message: e.message,code: e.response?.statusCode != null ? e.response?.statusCode : 0)
      );
    }
  }

  @override
  Future<Either> getSchBondsByYear(int yearId) async {
    try {
      final httpResponse = await _apiService.GetScheduleBondByYear(yearId: yearId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print(httpResponse.response);
        if (httpResponse.data.status) {
          return Right(httpResponse.data);

        } else {
          return Left(
              BaseResponseModel(status: false,message: httpResponse.data.message,code: httpResponse.response.statusCode)
          );
        }
      } else {
        print(httpResponse.response);
        return Left(
            BaseResponseModel(status: false,message: httpResponse.data.message,code: httpResponse.response.statusCode)
        );
      }
    } on DioException catch (e) {
      print(e);
      return Left(
          BaseResponseModel(status: false,message: e.message,code: e.response?.statusCode != null ? e.response?.statusCode : 0)
      );
    }
  }
}
