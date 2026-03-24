import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'processing_provider.dart';

class ProcessingScreen extends ConsumerWidget {
	const ProcessingScreen({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final diagnosisAsync = ref.watch(diagnosisLogicProvider);

		// Listen for completion to navigate
		ref.listen(diagnosisLogicProvider, (previous, next) {
			next.whenData((report) {
				// When data arrives, move to Report Screen
				context.pushReplacement('/report', extra: report);
			});
		});

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
							diagnosisAsync.maybeWhen(
								loading: () => const Text("Fetching GPS and contacting AI..."),
								error: (err, stack) => Text("Error: ${err.toString()}", 
									style: const TextStyle(color: Colors.red)),
								orElse: () => const Text("Finalizing report..."),
							),
						],
					),
				),
			),
		);
	}
}