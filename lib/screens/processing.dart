// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'package:biom/models/processing.dart';
import 'package:biom/state/processing_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class ProcessingScreen extends ConsumerWidget {
  const ProcessingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(simpleDiagStateProvider);

    if(state.currentStep == SimpleDiagnosisSteps.done) {
      context.pop(); context.push('report/${state.id}');
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              Text( state.userMessage,
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
