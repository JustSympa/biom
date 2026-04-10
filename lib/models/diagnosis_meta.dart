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