import 'dart:convert';
import 'dart:io';

import 'package:biom/services/api.dart';
import 'package:biom/services/kv.dart';
import 'package:biom/state/global.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:biom/models/processing.dart';
import 'package:biom/models/diagnosis.dart';
import 'package:path_provider/path_provider.dart';

final gpsProvider = FutureProvider<Position>((ref) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }
    
    return await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
  }
);

final responseProvider = FutureProvider<DiagnosisData>((ref) async {
  final pos = await ref.watch(gpsProvider.future);
  final input = ref.watch(diagnosisInputProvider);
  return await API.simpleReport(pos, input.description, KVS.language, [input.fullPic, input.fullPicName, input.symptomPic, input.symptomPicName]);
});


final savingProvider = FutureProvider<String>((ref) async {
  await ref.watch(gpsProvider.future);
  final diagnosis = await ref.watch(responseProvider.future);
  debugPrint('Report Generated successfully');

  final input = ref.watch(diagnosisInputProvider);
  input.symptomPic;

  final directory = await getApplicationDocumentsDirectory();
  final id = diagnosis.metadata.id;
  await Directory('${directory.path}/reports/${id.toString()}').create();
  await File(input.symptomPic).copy('${directory.path}/reports/${id.toString()}/image${input.symptomPicName.split('.')[-1]}');
  final reportFile = File('${directory.path}/reports/${id.toString()}/report.md');
  final metaFile = File('${directory.path}/reports/${id.toString()}/metadata.json');
  debugPrint('Saving Report');
  await reportFile.writeAsString(diagnosis.report);
  debugPrint('Saving Metadata');
  final json = diagnosis.metadata.toJSON();
  await metaFile.writeAsString(jsonEncode(json));
  return id;
});

// process_state_provider.dart

final simpleDiagStateProvider = Provider<SimpleDiagnosisState>((ref) {
  final t1 = ref.watch(gpsProvider);
  final t2 = ref.watch(responseProvider);
  final t3 = ref.watch(savingProvider);

  // Walk through steps in order — first unresolved step wins
  if (t1.isLoading) {
    return SimpleDiagnosisState(currentStep: SimpleDiagnosisSteps.gps);
  }
  if (t1.hasError) {
    return SimpleDiagnosisState(
      currentStep: SimpleDiagnosisSteps.gps,
      hasError: true,
      errorMessage: t1.error.toString(),
    );
  }

  if (t2.isLoading) {
    return SimpleDiagnosisState(currentStep: SimpleDiagnosisSteps.response);
  }
  if (t2.hasError) {
    return SimpleDiagnosisState(
      currentStep: SimpleDiagnosisSteps.response,
      hasError: true,
      errorMessage: t2.error.toString(),
    );
  }

  if (t3.isLoading) {
    return SimpleDiagnosisState(currentStep: SimpleDiagnosisSteps.save);
  }
  if (t3.hasError) {
    return SimpleDiagnosisState(
      currentStep: SimpleDiagnosisSteps.save,
      hasError: true,
      errorMessage: t3.error.toString(),
    );
  }

  // All 3 done successfully
  return SimpleDiagnosisState(
    currentStep: SimpleDiagnosisSteps.done,
    id: t3.value,
  );
});