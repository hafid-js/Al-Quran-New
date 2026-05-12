import 'package:dio/dio.dart';
import 'package:alquran_new/core/constants/api_endpoints.dart';
import 'package:alquran_new/core/utils/result.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrlV2,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  Future<Result<Response>> get(
    String path, {
    Map<String, dynamic>? queryParams,
    String? customBaseUrl,
  }) async {
    try {
      final fullPath = customBaseUrl != null ? '$customBaseUrl$path' : path;
      final response = await _dio.get(
        fullPath,
        queryParameters: queryParams,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(_mapDioError(e));
    }
  }

  Future<Result<Response>> post(
    String path, {
    dynamic data,
    String? customBaseUrl,
  }) async {
    try {
      final fullPath = customBaseUrl != null ? '$customBaseUrl$path' : path;
      final response = await _dio.post(
        fullPath,
        data: data,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(_mapDioError(e));
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi timeout. Periksa koneksi internet Anda.';
      case DioExceptionType.connectionError:
        return 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
      case DioExceptionType.badResponse:
        return 'Server error (${e.response?.statusCode}). Silakan coba lagi.';
      case DioExceptionType.cancel:
        return 'Permintaan dibatalkan.';
      default:
        return 'Terjadi kesalahan yang tidak terduga.';
    }
  }
}
