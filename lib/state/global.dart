import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biom/models/diagnosis.dart';
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


class _DiagnosisInputProvider extends Notifier<DiagnosisInput> {
  @override DiagnosisInput build () => DiagnosisInput();
  void setType(DiagnosisTypes type) { state = state.copyWith(type: type); }
  void setFullPicture(String path) { state = state.copyWith(fullPic: path); }
  void setSymptomPicture(String path) { state = state.copyWith(symptomPic: path); }
  void setDescription(String desc) { state = state.copyWith(description: desc); }
  void setQuestions(List<DiagnosisQA> qa) { state = state.copyWith(qa: qa); }
  void setAnswer(int i, String answer) {
    if(i >= state.qa.length) return;
    final qa = [...state.qa];
    qa[i] = DiagnosisQA(
      question: qa[i].question,
      answer: answer
    );
    state = state.copyWith(qa: qa);
  }
  void reset() { state = DiagnosisInput(); }
}
final diagnosisInputProvider = NotifierProvider(_DiagnosisInputProvider.new);