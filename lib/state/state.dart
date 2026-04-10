import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biom/models/diagnosis_meta.dart';
import 'package:path_provider/path_provider.dart';

class _DiagnosisHistoryNotifier extends AsyncNotifier<List<DiagnosisMeta>> {
  @override
  Future<List<DiagnosisMeta>> build() async {
    return await loadFromStorage();
  }

  Future<List<DiagnosisMeta>> loadFromStorage() async {
    final appdir = await getApplicationDocumentsDirectory();
    final reportsdir = Directory(p.join(appdir.path, 'reports'));
    if(!reportsdir.existsSync()) {
      reportsdir.createSync();
      return [];
    }
    final List<FileSystemEntity> reports = reportsdir.listSync();
    print(reports.length);
    final result = <DiagnosisMeta>[];
    for (var element in reports) {
      final metaFile = File(p.join(element.path, 'meta.json')).readAsStringSync();
      final metaData = await jsonDecode(metaFile);
      result.add(DiagnosisMeta(
        id: metaData['id'],
        createdAt: metaData['createdAt'],
        plantName: metaData['plantName'],
        healthStatus: metaData['healthStatus'],
        severity: metaData['severity'],
        disease: metaData['disease'],
        diseaseDescription: metaData['diseaseDescription'],
        confidence: metaData['confidence'],
        causes: metaData['causes'],
        symptoms: metaData['symptoms'],
        immediateSolutions: metaData['immediateSolutions'],
        longTermSolutions: metaData['longTermSolutions'],
        preventionTips: metaData['preventionTips'],
        longitude: metaData['longitude'],
        lattitude: metaData['lattitude']
      ));
    }
    return result;
  }

  void addDiagnosis(DiagnosisMeta diagnosis) { state = AsyncData([...state.value!, diagnosis]); }
  void deleteDiagnosis(String id) { state = AsyncData(state.value!.where((v) => v.id != id).toList()); }
}
final diagnosisHistoryProvider = AsyncNotifierProvider<_DiagnosisHistoryNotifier, List<DiagnosisMeta>>(_DiagnosisHistoryNotifier.new);

class SelectedImageNotifier extends Notifier<List<String>> {
  @override List<String> build () => [];
  void addImage(String path) {
    state = [...state, path];
  }
  void resetImages() {
    state = [];
  }
}
final selectedImagePathProvider = NotifierProvider(SelectedImageNotifier.new);

enum DiagnosisType { simple, advanced }
class DiagnosisTypeNotifier extends Notifier { @override DiagnosisType build () => DiagnosisType.simple; }
final diagnosisTypeProvider = NotifierProvider(DiagnosisTypeNotifier.new);