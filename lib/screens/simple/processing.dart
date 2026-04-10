// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class ProcessingScreen extends ConsumerWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final diagnosisState = ref.watch(diagnosisStateProvider);

    // final getStateText = () {
    //   switch (diagnosisState) {
    //     case DiagnosisState.gps_loading: return const Text("Fetching GPS ...");
    //     case DiagnosisState.gps_error: return const Text("Error while Fetching GPS", style: TextStyle(color: Colors.red));
    //     case DiagnosisState.response_loading: return const Text("Generating the report GPS ...");
    //     case DiagnosisState.response_error: return const Text("Error while Generating Response", style: TextStyle(color: Colors.red));
    //     case DiagnosisState.storing_response: return const Text("Storing the report ...");
    //     case DiagnosisState.storing_error: return const Text("Error while Storing the Report", style: TextStyle(color: Colors.red));
    //     case DiagnosisState.done: return const Text("Done");
    //   }
    // };

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              const Text(
                "Analyzing Plant Health...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // getStateText()
            ],
          ),
        ),
      ),
    );
  }
}
