import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/services/injection_container.dart';
import 'package:alquran_new/development/dev_alquran/data/datasources/surah_remote_data_source.dart';
import 'package:alquran_new/development/dev_alquran/data/local/surah_local_data_source.dart';
import 'package:alquran_new/development/dev_alquran/data/repositories/surah_repository_impl.dart';
import 'package:alquran_new/development/dev_alquran/domain/repositories/surah_repository.dart';
import 'package:alquran_new/development/dev_alquran/domain/usecases/get_all_surah.dart';
import 'package:alquran_new/development/dev_alquran/domain/usecases/get_detail_surah.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/detail_surah_bloc.dart';
import 'package:alquran_new/development/dev_alquran/presentation/bloc/surah_bloc.dart';
import 'package:alquran_new/development/dev_doa/presentation/bloc/doa_bloc.dart';
import 'package:alquran_new/development/dev_doa/data/datasources/doa_remote_data_source.dart';
import 'package:alquran_new/development/dev_doa/data/repositories/doa_repository_impl.dart';
import 'package:alquran_new/development/dev_doa/domain/repositories/doa_repository.dart';
import 'package:alquran_new/development/dev_doa/domain/usecases/get_all_doa.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;


void initDevAlquran() {
  if (!sl.isRegistered<DioClient>()) {
    sl.registerLazySingleton(() => DioClient());
  }

  if (!sl.isRegistered<SurahRemoteDataSource>()) {
    sl.registerLazySingleton<SurahRemoteDataSource>(
      () => SurahRemoteDataSourceImpl(sl()),
    );
  }

  if(!sl.isRegistered<SurahLocalDataSource>()) {
    sl.registerLazySingleton<SurahLocalDataSource> (
      () => SurahLocalDataSourceImpl()
    );
  }

  if (!sl.isRegistered<SurahRepository>()) {
    sl.registerLazySingleton<SurahRepository>(() => SurahRepositoryImpl(sl(), sl()));
  }


  if (!sl.isRegistered<GetAllSurah>()) {
    sl.registerLazySingleton(() => GetAllSurah(sl()));
  }

  if (!sl.isRegistered<GetDetailSurah>()) {
    sl.registerLazySingleton(() => GetDetailSurah(sl()));
  }

  if (!sl.isRegistered<SurahBloc>()) {
    sl.registerFactory(() => SurahBloc(getAllSurah: sl()));
  }

  if (!sl.isRegistered<DetailSurahBloc>()) {
    sl.registerFactory(() => DetailSurahBloc(getDetailSurah: sl()));
  }


  if (!sl.isRegistered<DoaRemoteDataSource>()) {
    sl.registerLazySingleton<DoaRemoteDataSource>(
      () => DoaRemoteDataSourceImpl(sl()),
    );
  }

  // if(!sl.isRegistered<SurahLocalDataSource>()) {
  //   sl.registerLazySingleton<SurahLocalDataSource> (
  //     () => SurahLocalDataSourceImpl()
  //   );
  // }

  if (!sl.isRegistered<DoaRepository>()) {
    sl.registerLazySingleton<DoaRepository>(() => DoaRepositoryImpl(sl(), sl()));
  }


  if (!sl.isRegistered<GetAllDoa>()) {
    sl.registerLazySingleton(() => GetAllDoa(sl()));
  }

  if (!sl.isRegistered<DoaBloc>()) {
    sl.registerFactory(() => DoaBloc(getAllDoa: sl()));
  }

}
