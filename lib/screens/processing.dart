// ignore_for_file: unused_local_variable, prefer_function_declarations_over_variables

import 'package:biom/models/processing.dart';
import 'package:biom/state/processing_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class ProcessingScreen extends ConsumerWidget {
  const ProcessingScreen({super.key});

  void _onSeeReport(String id, BuildContext context) {
      context.pop(); context.push('/report/$id');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(simpleDiagStateProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Processing"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(state.id != null) ...[
                Icon(Icons.check_circle, color: colors.primary, size: 36.0,),
                const SizedBox(height: 24),
                Text( state.userMessage,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextButton(onPressed: () => _onSeeReport(state.id!, context), child: const Text('See Report'))
              ]
              else if(!state.hasError) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                Text( state.userMessage,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ]
              else ...[
                const Icon(Icons.warning, size: 32, color: Colors.red,),
                const SizedBox(height: 24),
                Text(
                  '${state.errorMessage}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () { context.pop(); },
                  child: const Text('Go Back'),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
