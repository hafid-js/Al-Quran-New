import 'package:alquran_new/core/constants/app_constants.dart';
import 'package:alquran_new/development/masjid_terdekat/data/models/masjid_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class MasjidRemoteDatasource {
  Future<List<MasjidModel>> fetchMasjidsTerdekat(
    double lat,
    double lng,
    int radius,
  );
}

class MasjidRemoteDatasourceImpl implements MasjidRemoteDatasource {
  final Dio client;

  MasjidRemoteDatasourceImpl({required this.client});

  @override
  Future<List<MasjidModel>> fetchMasjidsTerdekat(
    double lat,
    double lng,
    int radius,
  ) async {
    if (AppConstants.googleApiKey.isEmpty) {
      throw Exception(
        'GOOGLE_MAPS_API_KEY belum diatur. Salin .env.example menjadi .env '
        'lalu isi API key-nya.',
      );
    }

    try {
      final response = await client.post(
        'https://places.googleapis.com/v1/places:searchNearby',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': AppConstants.googleApiKey,

            'X-Goog-FieldMask':
                'places.id,places.displayName,places.location,'
                'places.formattedAddress,places.rating',
          },
        ),

        data: {
          'includedTypes': ['mosque'],
          'maxResultCount': 20,
          'locationRestriction': {
            'circle': {
              'center': {'latitude': lat, 'longitude': lng},
              'radius': radius.toDouble(),
            },
          },
          'languageCode': 'id',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final places = data['places'] as List? ?? [];

        return places.map((json) => MasjidModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Gagal terhubung ke Google Places API: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      debugPrint('DIO ERROR: ${e.response?.data ?? e.message}');
      throw Exception('Gagal memuat data masjid: ${e.message}');
    }
  }
}
