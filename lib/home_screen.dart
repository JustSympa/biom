import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  	const HomeScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Plant Diagnosis History')),
			body: const Center(
				child: Text('Your diagnosis history will appear here.'),
			),
			floatingActionButton: FloatingActionButton.extended(
				onPressed: () => _showSelectionDialog(context),
				label: const Text('New Diagnosis'),
				icon: const Icon(Icons.add),
			),
		);
  	}

	void _showSelectionDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (context) => SimpleDialog(
				title: const Text('Choose Diagnosis Type'),
				children: [
					SimpleDialogOption(
						onPressed: () {
						context.pop(); // Close dialog
						context.push('/photo/simple');
						},
						child: const ListTile(
						leading: Icon(Icons.bolt),
						title: Text('Simple'),
						subtitle: Text('Fast AI analysis'),
						),
					),
					SimpleDialogOption(
						onPressed: () {
						context.pop(); // Close dialog
						context.push('/photo/advanced');
						},
						child: const ListTile(
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