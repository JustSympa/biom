enum SimpleDiagnosisSteps { gps, response, save, done }

class SimpleDiagnosisState {
  final SimpleDiagnosisSteps currentStep;
  final String? errorMessage;
  final String? id;
  final bool hasError;
  
  SimpleDiagnosisState({ this.currentStep = SimpleDiagnosisSteps.gps, this.errorMessage, this.id, this.hasError = false });
  
  factory SimpleDiagnosisState.error(SimpleDiagnosisSteps step, String message) {
    return SimpleDiagnosisState(
      currentStep: step,
      errorMessage: message,
      hasError: true,
    );
  }
  
  SimpleDiagnosisState copyWith({
    SimpleDiagnosisSteps? currentStep,
    String? errorMessage,
    String? id,
    bool? hasError,
  }) {
    return SimpleDiagnosisState(
      currentStep: currentStep ?? this.currentStep,
      errorMessage: errorMessage ?? this.errorMessage,
      id: id ?? this.id,
      hasError: hasError ?? this.hasError,
    );
  }
  
  String get userMessage {
    if (hasError) return 'Error: $errorMessage';
    
    switch (currentStep) {
      case SimpleDiagnosisSteps.gps:
        return 'Loading GPS info...';
      case SimpleDiagnosisSteps.response:
        return 'Analysing and Generating Report...';
      case SimpleDiagnosisSteps.save:
        return 'Saving report...';
      case SimpleDiagnosisSteps.done:
        return 'Complete!';
    }
  }
}