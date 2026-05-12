import 'package:alquran_new/core/network/dio_client.dart';
import 'package:alquran_new/core/utils/result.dart';
import 'package:alquran_new/features/home/data/models/prayer_time_response_dto.dart';
import 'package:intl/intl.dart';

abstract class PrayerTimeRemoteDataSource {
  Future<Result<PrayerTimeResponseDTO>> fetchPrayerTimes({
    required String province,
    required String city,
  });
}

class PrayerTimeRemoteDataSourceImpl implements PrayerTimeRemoteDataSource {
  final DioClient _client;

  PrayerTimeRemoteDataSourceImpl(this._client);

  @override
  Future<Result<PrayerTimeResponseDTO>> fetchPrayerTimes({
    required String province,
    required String city,
  }) async {
    final result = await _client.post(
      '/shalat',
      data: {
        'provinsi': province,
        'kabkota': city,
        'bulan_nama': DateFormat.MMMM('id').format(DateTime.now()),
        'tahun': DateTime.now().year,
      },
    );
    return result.when(
      success: (response) {
        final dto = PrayerTimeResponseDTO.fromJson(response.data);
        return Success(dto);
      },
      failure: (message, statusCode) => Failure(message, statusCode: statusCode),
    );
  }
}
