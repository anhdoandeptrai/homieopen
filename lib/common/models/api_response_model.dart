class ApiResponseModel<T> {
  ApiResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final int? status;
  final String? message;
  final T? data;

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? rawData) fn,
  ) {
    return ApiResponseModel(
      status: json["status"],
      message: json["message"],
      data: json['data'] == null ? null : fn(json['data']),
    );
  }
}