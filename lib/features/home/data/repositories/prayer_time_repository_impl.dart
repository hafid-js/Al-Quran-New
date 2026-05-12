import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/home/data/datasources/prayer_time_remote_data_source.dart';
import 'package:alquran_new/features/home/domain/repositories/prayer_time_repository.dart';

class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerTimeRemoteDataSource _remoteDataSource;

  PrayerTimeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<PrayerTimeResponse>> getPrayerTimes({
    required String province,
    required String city,
  }) async {
    final result = await _remoteDataSource.fetchPrayerTimes(
      province: province,
      city: city,
    );
    return result.when(
      success: (dto) {
        final entities = dto.schedules.map((e) => e.toEntity()).toList();
        return Success(PrayerTimeResponse(
          province: dto.province,
          city: dto.city,
          schedules: entities,
        ));
      },
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }
}
