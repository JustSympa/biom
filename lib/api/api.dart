import 'package:biom/models/diagnosis_data.dart';
import 'package:biom/models/diagnosis_meta.dart';
import 'package:dio/dio.dart';
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
      onError:(error, handler) async {
        if(error.response?.statusCode == 401) {
          try {
            final newToken = await Dio(BaseOptions(baseUrl: dotenv.env['SERVER'] ?? ''))
            .post( _Routes.refresh, data: { 'refreshToken': refreshToken } );
            dio.options.headers['Authorization'] = 'Bearer ${newToken.data}';
            error.requestOptions.headers['Authorization'] = 'Bearer ${newToken.data}';
            final response = await dio.fetch(error.requestOptions);
            return handler.resolve(response);
          } catch (e) {
            return handler.next(error);
          }
        }
        return handler.next(error);
      },
    )); 
  }

  static Future<String> refreshAccessToken() async {
    final response = await dio.post(_Routes.refresh, data: { 'refreshToken': refreshToken});
    dio.options.headers['Authorization'] = 'Bearer ${response.data['accessToken']}';
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
      'lattitude': pos.latitude,
      'description': description,
      'language': lang,
      'files': [
        await MultipartFile.fromFile(images[0], filename: 'image1'),
        await MultipartFile.fromFile(images[1], filename: 'image2'),
        await MultipartFile.fromFile(images[2], filename: 'image3')
      ]
    });
    final response = await dio.post(_Routes.report, data: form);
    return DiagnosisData(
      metadata: DiagnosisMeta(
        id: response.data['id'],
        createdAt: response.data['createdAt'],
        plantName: response.data['plantName'],
        healthStatus: response.data['healthStatus'],
        severity: response.data['severity'],
        disease: response.data['disease'],
        diseaseDescription: response.data['diseaseDescription'],
        confidence: response.data['confidence'],
        causes: response.data['causes'],
        symptoms: response.data['symptoms'],
        immediateSolutions: response.data['immediateSolutions'],
        longTermSolutions: response.data['longTermSolutions'],
        preventionTips: response.data['preventionTips'],
        longitude: pos.longitude,
        lattitude: pos.latitude
        ),
      report: response.data['report']
    );
  }  
}