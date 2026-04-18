import 'package:biom/models/diagnosis.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class _Routes {
  static final String initUser = "/auth/init";
  static final String refresh = "/auth/refresh";
  // static final String userInfo = "/auth/me";
  static final String report = "/report";
  // static final String reportHistory = "/report/history";
}

class API {
  static final dio = Dio(BaseOptions(baseUrl: dotenv.env['SERVER'] ?? ''));
  static String refreshToken = '';

  static void init(String refreshToken) {
    dio.options.baseUrl = dotenv.env['SERVER'] ?? '';
    dio.interceptors.clear();
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Querying ${options.path}');
        // debugPrint('Sending ${options.}')
        return handler.next(options);
      },
      onError:(error, handler) async {
        debugPrint(error.message);
        if(error.response?.statusCode == 401) {
          debugPrint("Token Expired");
          try {
            final newToken = await Dio(BaseOptions(baseUrl: dotenv.env['SERVER'] ?? ''))
            .post( _Routes.refresh, data: { 'refreshToken': refreshToken } );
            debugPrint('New token ${newToken.data['accessToken']}');
            dio.options.headers['Authorization'] = 'Bearer ${newToken.data['accessToken']}';
            error.requestOptions.headers['Authorization'] = 'Bearer ${newToken.data['accessToken']}';
            final response = await dio.fetch(error.requestOptions);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    ));
    if(refreshToken.isNotEmpty) refreshAccessToken(); 
  }

  static Future<String> refreshAccessToken() async {
    final response = await dio.post(_Routes.refresh, data: { 'refreshToken': refreshToken});
    dio.options.headers['Authorization'] = 'Bearer ${response.data['accessToken']}';
    debugPrint('Access Token: ${response.data['accessToken']}');
    return response.data['accessToken'];
  }

  static Future<String> initUser() async {
    final response = await dio.post(_Routes.initUser);
    dio.options.headers['Authorization'] = 'Bearer ${response.data['accessToken']}';
    return response.data['refreshToken'];
  }

  static Future<DiagnosisData> simpleReport(Position pos, String description, String lang, List<String> images) async {
    final form = FormData.fromMap({
      'longitude': pos.longitude,
      'latitude': pos.latitude,
      'description': description,
      'language': lang,
      'image': [
        await MultipartFile.fromFile(images[0], filename: images[1]),
        await MultipartFile.fromFile(images[2], filename: images[3]),
      ]
    });
    final response = await dio.post(_Routes.report, data: form, options: Options(receiveTimeout: Duration(minutes: 2)));
    final data = response.data as Map<String, dynamic>;
    data['longitude'] = pos.longitude;
    data['latitude'] = pos.latitude;
    return DiagnosisData.fromJSON(data);
  }  
}