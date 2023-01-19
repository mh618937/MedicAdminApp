import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = "http://13.234.225.223:5000";
    _dio.interceptors.add(PrettyDioLogger());
  }
  Dio get sendRequest => _dio;
}
