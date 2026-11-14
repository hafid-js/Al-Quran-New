class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;

  const ApiResponse({this.code = 0, this.message = '', this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? data) parseData,
  ) {
    return ApiResponse(
      code: (json['code'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? '',
      data: json['data'] == null ? null : parseData(json['data']),
    );
  }
}
