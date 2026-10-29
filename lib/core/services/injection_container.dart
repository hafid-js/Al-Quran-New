

import 'package:alquran_new/development/masjid_terdekat/data/datasources/masjid_remote_datasource.dart';
import 'package:alquran_new/development/masjid_terdekat/data/repositories/masjid_repository_impl.dart';
import 'package:alquran_new/development/masjid_terdekat/domain/repositories/masjid_repository.dart';
import 'package:alquran_new/development/masjid_terdekat/domain/usecases/get_masjids_terdekat.dart';
import 'package:alquran_new/development/masjid_terdekat/presentation/bloc/masjid_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerFactory(() => MasjidBloc(getMasjidsTerdekat: sl()));

  sl.registerLazySingleton(() => GetMasjidsTerdekat(sl()));

  sl.registerLazySingleton<MasjidRepository> (
    () => MasjidRepositoryImpl(remoteDatasource: sl())
  );

  sl.registerLazySingleton<MasjidRemoteDatasource> (
    () => MasjidRemoteDatasourceImpl(client: sl())
  );

  // Timeout wajib ada, kalau tidak request yang menggantung akan membuat
  // UI berputar loading selamanya.
  sl.registerLazySingleton(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    ),
  );
}