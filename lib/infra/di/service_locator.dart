import 'dart:io';
import 'package:check_bond/data/data_sources/local/hive_manager.dart';
import 'package:check_bond/data/data_sources/remote/api_service.dart';
import 'package:check_bond/data/repositories/auth/auth_repository_impl.dart';
import 'package:check_bond/data/repositories/bond/bond_repository_impl.dart';
import 'package:check_bond/domain/auth/contracts/auth_repository.dart';
import 'package:check_bond/domain/auth/usecase/auth_usecases.dart';
import 'package:check_bond/domain/bond/contracts/bond_repository.dart';
import 'package:check_bond/domain/bond/usecase/bond_usecases.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../configs/config_exports.dart';


final sl = GetIt.instance;

Future<void> initializedDepencies() async {
  await HiveManager.init();

  final dio = Dio();
  // final baseUrl = getBaseUrl();  // Get the platform-specific base URL
  final baseUrl = APIBaseURL;  // Get the platform-specific base URL

  if(kIsWeb) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(minutes: 2),
      receiveTimeout: Duration(minutes: 2),
      validateStatus: (status) {
        // Allow all statuses (or customize as needed)
        return status != null && status < 500;
      }
    );
  } else {
    final securityContext = SecurityContext(withTrustedRoots: true);
    final httpClient = HttpClient(context: securityContext);

    dio.httpClientAdapter = IOHttpClientAdapter()
      ..createHttpClient = () {
        return httpClient;
      };
  }

  dio.options = BaseOptions(
    baseUrl: baseUrl,  // Set the platform-specific base URL
    connectTimeout: Duration(minutes: 2),
    receiveTimeout: Duration(minutes: 2),
      validateStatus: (status) {
        // Allow all statuses (or customize as needed)
        return status != null && status < 500;
      }
  );

  dio.interceptors.addAll([
    LoggingInterceptor(),
    AuthInterceptor(),
  ]);

  sl.registerSingleton<Dio>(dio);

  // Remote Api Services
  sl.registerSingleton(ApiService(sl()));

  // repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
   sl.registerSingleton<BondRepository>(BondRepositoryImpl(sl()));
  // sl.registerSingleton<UploadRepository>(UploadRepositoryImpl(sl()));
  // sl.registerSingleton<AdminRepository>(AdminRepositoryImpl(sl()));

  // usecases
  sl.registerSingleton<AuthUsecases>(AuthUsecases(sl()));
  sl.registerSingleton<BondUsecases>(BondUsecases(sl()));
  // sl.registerSingleton<UploadUsecase>(UploadUsecase(sl()));
  // sl.registerSingleton<AdminUsecase>(AdminUsecase(sl()));
  // // sl.registerSingleton<ChangePasswordUsecase>(ChangePasswordUsecase(sl()));

}