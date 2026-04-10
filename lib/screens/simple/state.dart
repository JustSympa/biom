enum ProcessStep { gps_loading, gps_error, response_loading, response_error, storing_response, storing_error, completed }

class ProcessState {
  final ProcessStep currentStep;
  final String? errorMessage;
  final bool hasError;
  
  ProcessState({ this.currentStep = ProcessStep.gps_loading, this.errorMessage, this.hasError = false });
  
  factory ProcessState.error(ProcessStep step, String message) {
    return ProcessState(
      currentStep: step,
      errorMessage: message,
      hasError: true,
    );
  }
  
  ProcessState copyWith({
    ProcessStep? currentStep,
    String? errorMessage,
    bool? hasError,
  }) {
    return ProcessState(
      currentStep: currentStep ?? this.currentStep,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
    );
  }
  
  String get userMessage {
    if (hasError) return 'Error: $errorMessage';
    
    switch (currentStep) {
      case ProcessStep.gps_loading:
        return 'Loading GPS info...';
      case ProcessStep.gps_error:
        return 'Error while fetching GPS info';
      case ProcessStep.response_loading:
        return 'Analysing and Generating Report...';
      case ProcessStep.response_error:
        return 'Error while analysing';
      case ProcessStep.storing_response:
        return 'Storing report...';
      case ProcessStep.storing_error:
        return 'Error while storing report';
      case ProcessStep.completed:
        return 'Complete!';
    }
  }
}