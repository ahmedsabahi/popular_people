import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp/utils/constants.dart';

final dioClientProvider = ChangeNotifierProvider<DioClient>(
  (ref) => DioClient(),
);

class DioClient with ChangeNotifier {
  final Dio _dio;
  Dio get dio => _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.themoviedb.org/3',
            queryParameters: {
              "language": "en-US",
              "api_key": AppConstants.apiKeyAuth,
            },
            contentType: Headers.jsonContentType,
          ),
        )..interceptors.add(AppInterceptors());
}

class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) print("::: Api request : ${options.uri}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) print("::: Api response : $response");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) print("::: Api error : $err");
    return handler.next(err);
  }
}
