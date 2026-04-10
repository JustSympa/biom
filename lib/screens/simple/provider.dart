// ignore_for_file: non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../state/state.dart';

final gpsDataProvider = FutureProvider<Position>((ref) async => await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high)) );

class DiagnosisReport {
  final String report;
  final Map<String, dynamic> metadata;

  DiagnosisReport({required this.report, required this.metadata});
}

// final diagnosisPromptProvider = FutureProvider<DiagnosisReport>((ref) async {
// 	final imagePath = ref.watch(selectedImagePathProvider);
//   final position = await ref.watch(gpsDataProvider.future);
// 	final type = ref.watch(diagnosisTypeProvider);

// });

// final diagnosisStorageProvider = FutureProvider<String>((ref) async {
//   final response = await ref.watch(diagnosisPromptProvider.future);
//   final directory = await getApplicationDocumentsDirectory();
//   final id = DateTime.now().millisecondsSinceEpoch - DateTime.parse("2026-03-24").millisecondsSinceEpoch;
//   final report_file = File('${directory.path}/${id.toString()}/report.md');
//   final meta_file = File('${directory.path}/${id.toString()}/metadata.json');
//   await report_file.writeAsString(response.report);
//   await meta_file.writeAsString(response.metadata.toString());
//   return id.toString();
// });

enum DiagnosisState { gps_loading, gps_error, response_loading, response_error, storing_response, storing_error, done}

// final diagnosisStateProvider = Provider<DiagnosisState>((ref) {
//   DiagnosisState result = DiagnosisState.gps_loading;
//   final gps = ref.watch(gpsDataProvider);
//   result = gps.when(loading: () => DiagnosisState.gps_loading, error: (err, stack) => DiagnosisState.gps_error, data: (data) => DiagnosisState.response_loading);
//   if(result != DiagnosisState.response_loading) return result;
//   final response = ref.watch(diagnosisPromptProvider);
//   result = response.when(loading: () => DiagnosisState.response_loading, error: (err, stack) => DiagnosisState.response_error, data: (data) => DiagnosisState.storing_response);
//   if(result != DiagnosisState.storing_response) return result;
//   final storage = ref.watch(diagnosisStorageProvider);
//   result = storage.when(loading: () => DiagnosisState.storing_response, error: (err, stack) => DiagnosisState.storing_error, data: (data) => DiagnosisState.done);
//   return result;
// });