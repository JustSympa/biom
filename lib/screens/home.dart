import 'package:biom/services/kv.dart';
import 'package:biom/models/diagnosis.dart';
import 'package:biom/state/global.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biom/widgets/home/diagnosis_brief.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
	const HomeScreen({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
    final diagnosisHistory = ref.watch(diagnosisHistoryProvider);
    final colors = Theme.of(context).colorScheme;

		return Scaffold(
			appBar: AppBar(
        backgroundColor: colors.primaryContainer,
        title: Row(
          spacing: 12,
          children: [
            Icon(Icons.history, size: 36, color: colors.primary ),
            Text('History', style: TextStyle(color: colors.primary),)
          ],
        )
      ),
			body: Center(
				child: diagnosisHistory.when(
          loading: () => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  const Text(
                    "Loading Past Diagnosis...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          error: (error, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning, size: 32, color: Colors.red,),
                  const SizedBox(height: 24),
                  const Text(
                    "Something went wrong!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.info_rounded, size: 32, color: Colors.grey,),
                      const SizedBox(height: 24),
                      const Text(
                        "No Diagnosis to display",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder:(context, index) => DiagnosisbriefWidget(diag: data[index]),
                padding: const EdgeInsets.only(bottom: 40.0),
              );
            }
          }
        ),
			),
			floatingActionButton: FloatingActionButton.extended(
				onPressed: () => KVS.skipInstructions ? _showSelectionDialog(context, ref) : _showInstrutionsDialog(context, ref),
				label: const Text('New Diagnosis'),
				icon: Icon(Icons.add),
			),
		);
		}

  void _showInstrutionsDialog(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
		showDialog(
			context: context,
			builder: (context) => SimpleDialog(
				title: Text('Follow the instructions', style: TextStyle(fontWeight: FontWeight.w600),),
        contentPadding: const EdgeInsetsGeometry.all(16),
				children: [
          Row(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('1.', style: TextStyle(fontWeight: FontWeight.bold),),
              Expanded(child: const Text("Take a full picture of the plant to help for identify.", softWrap: true,)),
            ],
          ),
          Row(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('2.', style: TextStyle(fontWeight: FontWeight.bold),),
              Expanded(child: const Text("Take a picture of the part that draw your attention.", softWrap: true,)),
            ],
          ),
          Row(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('3.', style: TextStyle(fontWeight: FontWeight.bold),),
              Expanded(child: const Text("Write a small description of what you've noticed.", softWrap: true,)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  context.pop(); // Close dialog
                  KVS.skipInstructions = true;
                  _showSelectionDialog(context, ref);
                },
                child: Text('Skip Instructions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: colors.primary),),
              ),
              SimpleDialogOption(
                onPressed: () {
                  context.pop(); // Close dialog
                  _showSelectionDialog(context, ref);
                },
                child: Text('Ok', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: colors.primary),),
              ),
              SimpleDialogOption(
                onPressed: () {
                  context.pop(); // Close dialog
                },
                child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: colors.primary),),
              ),
            ],
          ),
				],
			),
		);
	}

	void _showSelectionDialog(BuildContext context, WidgetRef ref) {
    final inputState = ref.read(diagnosisInputProvider.notifier);
		showDialog(
			context: context,
			builder: (context) => SimpleDialog(
				title: Text('Choose Diagnosis Type'),
				children: [
					SimpleDialogOption(
						onPressed: () {
              inputState.reset();
              inputState.setType(DiagnosisTypes.simple);
              context.pop(); // Close dialog
              context.push('/photo');
						},
						child: ListTile(
						leading: Icon(Icons.bolt),
						title: Text('Simple'),
						subtitle: Text('Fast AI analysis'),
						),
					),
					SimpleDialogOption(
						onPressed: () {
              inputState.reset();
              inputState.setType(DiagnosisTypes.advanced);
              context.pop(); // Close dialog
              context.push('/photo');
						},
						child: ListTile(
						leading: Icon(Icons.settings),
						title: Text('Advanced'),
						subtitle: Text('In-depth questionnaire'),
						),
					),
				],
			),
		);
		}
}