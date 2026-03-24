import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class ReportScreen extends StatelessWidget {
	final String reportMarkdown;

	// GoRouter passes the 'extra' object here
	const ReportScreen({super.key, required this.reportMarkdown});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Diagnosis Report'),
				actions: [
					IconButton(
						icon: const Icon(Icons.share),
						onPressed: () {
							// Logic to share the report later
						},
					),
				],
			),
			body: Column(
				children: [
					// The Markdown Renderer
					Expanded(
						child: Markdown(
							data: reportMarkdown,
							selectable: true,
							styleSheet: MarkdownStyleSheet(
								h1: const TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
								p: const TextStyle(fontSize: 16, height: 1.5),
								listBullet: const TextStyle(color: Colors.green),
							),
						),
					),
					
					// Bottom Action Bar
					Padding(
						padding: const EdgeInsets.all(20.0),
						child: SizedBox(
							width: double.infinity,
							height: 50,
							child: FilledButton.icon(
								onPressed: () => context.go('/'), // context.go resets the stack to Home
								icon: const Icon(Icons.home),
								label: const Text('Back to History'),
								style: FilledButton.styleFrom(backgroundColor: Colors.green),
							),
						),
					),
				],
			),
		);
	}
}