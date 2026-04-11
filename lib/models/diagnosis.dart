
import 'dart:convert';

class DiagnosisMeta {
  final String id;
  final DateTime createdAt;
  final String? plantName;
  final String healthStatus;
  final String? severity;
  final String? disease;
	final String? diseaseDescription;
	final double confidence;
  final List<String> causes;
  final List<String> symptoms;
  final List<String> immediateSolutions;
	final List<String> longTermSolutions;
  final List<String> preventionTips;
  final double longitude;
  final double lattitude; 
  const DiagnosisMeta({
    required this.id, 
    required this.createdAt, 
    this.plantName, 
    required this.healthStatus,
    this.severity,
    this.disease,
    this.diseaseDescription,
    required this.confidence,
    required this.causes,
    required this.symptoms,
    required this.immediateSolutions,
    required this.longTermSolutions,
    required this.preventionTips,
    required this.longitude,
    required this.lattitude
  });
}

class DiagnosisData {
  final DiagnosisMeta metadata;
  final String report;
  const DiagnosisData({required this.metadata, required this.report});
  factory DiagnosisData.fromJSON(Map<String, dynamic> json) {
    return DiagnosisData(
      metadata: DiagnosisMeta(
        id: json['id'],
        createdAt: json['createdAt'],
        healthStatus: json['healthStatus'],
        confidence: json['confidence'],
        causes: json['causes'],
        symptoms: json['symptoms'],
        immediateSolutions: json['immediateSolutions'],
        longTermSolutions: json['longTermSolutions'],
        preventionTips: json['preventionTips'],
        longitude: json['longitude'],
        lattitude: json['lattitude']
      ),
      report: json['report']
    );
  }
}

class DiagnosisQA {
  String question = '';
  String answer = '';
  DiagnosisQA({required this.question, required this.answer});
}

class DiagnosisInput {
  DiagnosisTypes type = DiagnosisTypes.unset;
  String fullPic = '';
  String symptomPic = '';
  String description = '';
  List<DiagnosisQA> qa = [];

  DiagnosisInput copyWith({DiagnosisTypes? type, String? fullPic, String? symptomPic, String? description, List<DiagnosisQA>? qa}) {
    var result = DiagnosisInput();
    result.type = type ?? this.type;
    result.fullPic = fullPic ?? this.fullPic;
    result.symptomPic = symptomPic ?? this.symptomPic;
    result.description = description ?? this.description;
    result.qa = qa ?? this.qa;
    return result;
  }
}

enum DiagnosisTypes { unset, simple, advanced }

enum PhotoTypes {
  identifySimple, problemSimple,
  identifyAdvanced, problemAdvenced
}