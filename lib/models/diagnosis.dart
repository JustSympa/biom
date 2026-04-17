
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
  final double latitude; 
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
    required this.latitude
  });
  factory DiagnosisMeta.fromJSON(Map<String, dynamic> json) {
    return DiagnosisMeta(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      plantName: json['plantName'],
      healthStatus: json['healthStatus'],
      severity: json['severity'],
      disease: json['disease'],
      diseaseDescription: json['diseaseDescription'],
      confidence: (json['confidence'] as num).toDouble(),
      causes: List<String>.from(json['causes'] ?? const []),
      symptoms: List<String>.from(json['symptoms'] ?? const []),
      immediateSolutions: List<String>.from(json['immediateSolutions'] ?? const []),
      longTermSolutions: List<String>.from(json['longTermSolutions'] ?? const []),
      preventionTips: List<String>.from(json['preventionTips'] ?? const []),
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble()
    );
  }
  Map<String, dynamic> toJSON() {
    final result = <String, dynamic>{};
    result['id'] = id;
    result['createdAt'] = createdAt.toIso8601String();
    result['plantName'] = plantName;
    result['healthStatus'] = healthStatus;
    result['severity'] = severity;
    result['disease'] = disease;
    result['diseaseDescription'] = diseaseDescription;
    result['confidence'] = confidence;
    result['causes'] = causes;
    result['symptoms'] = symptoms;
    result['immediateSolutions'] = immediateSolutions;
    result['longTermSolutions'] = longTermSolutions;
    result['preventionTips'] = preventionTips;
    result['longitude'] = longitude;
    result['latitude'] = latitude;
    return result;
  }
}

class DiagnosisData {
  final DiagnosisMeta metadata;
  final String report;
  const DiagnosisData({required this.metadata,
    required this.report});
  factory DiagnosisData.fromJSON(Map<String, dynamic> json) {
    return DiagnosisData(
      metadata: DiagnosisMeta(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt'] as String),
        plantName: json['plantName'],
        healthStatus: json['healthStatus'],
        severity: json['severity'],
        disease: json['disease'],
        diseaseDescription: json['diseaseDescription'],
        confidence: (json['confidence'] as num).toDouble(),
        causes: List<String>.from(json['causes'] ?? const []),
        symptoms: List<String>.from(json['symptoms'] ?? const []),
        immediateSolutions: List<String>.from(json['immediateSolutions'] ?? const []),
        longTermSolutions: List<String>.from(json['longTermSolutions'] ?? const []),
        preventionTips: List<String>.from(json['preventionTips'] ?? const []),
        longitude: (json['longitude'] as num).toDouble(),
        latitude: (json['latitude'] as num).toDouble()
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
  String fullPicName = '';
  String symptomPicName = '';
  String description = '';
  List<DiagnosisQA> qa = [];

  DiagnosisInput copyWith({DiagnosisTypes? type, String? fullPic, String? symptomPic, String? fullPicName, String? symptomPicName, String? description, List<DiagnosisQA>? qa}) {
    var result = DiagnosisInput();
    result.type = type ?? this.type;
    result.fullPic = fullPic ?? this.fullPic;
    result.symptomPic = symptomPic ?? this.symptomPic;
    result.fullPicName = fullPicName ?? this.fullPicName;
    result.symptomPicName = symptomPicName ?? this.symptomPicName;
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