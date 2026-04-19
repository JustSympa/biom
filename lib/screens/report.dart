import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';

class ReportScreen extends StatefulWidget {
	final String reportID;

	// GoRouter passes the 'extra' object here
	const ReportScreen({super.key, required this.reportID});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late Future<String> _report;

  @override
  void initState() {
    super.initState();
    _report = _loadReport();
  }

  Future<String> _loadReport() async {
    final appdir = await getApplicationDocumentsDirectory();
    final reportFile = File(p.join(appdir.path, 'reports', widget.reportID, 'report.md'));
    if(!reportFile.existsSync()) {
      return "This Report does not Exists!";
    }
    final result = await reportFile.readAsString();
    return result;
  }

	@override
	Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
		return Scaffold(
			appBar: AppBar(
        backgroundColor: colors.primaryContainer,
				title: Row(
          spacing: 12,
          children: [
            Icon(Icons.description, size: 36, color: colors.primary ),
            Text('Diagnosis Report', style: TextStyle(color: colors.primary),)
          ],
        ),
				// actions: [
				// 	IconButton(
				// 		icon: const Icon(Icons.share),
				// 		onPressed: () {
				// 			// Logic to share the report later
				// 		},
				// 	),
				// ],
			),
			body: FutureBuilder(
        future: _report,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center( widthFactor: 0.5, heightFactor: 0.5, child: const CircularProgressIndicator(),);
          }
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning, size: 32, color: Colors.red,),
                    const SizedBox(height: 24),
                    Text(
                      '${snapshot.error}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                  ]
                )
              )
            );

          }
          else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Markdown(
                data: snapshot.data ?? 'Nothing to Display',
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  h1: const TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
                  p: const TextStyle(fontSize: 16, height: 1.5),
                  listBullet: const TextStyle(color: Colors.green),
                ),
              ),
            );
          }
        },
					
					
					// Padding(
					// 	padding: const EdgeInsets.all(20.0),
					// 	child: SizedBox(
					// 		width: double.infinity,
					// 		height: 50,
					// 		child: FilledButton.icon(
					// 			onPressed: () => context.go('/'), // context.go resets the stack to Home
					// 			icon: const Icon(Icons.home),
					// 			label: const Text('Back to History'),
					// 			style: FilledButton.styleFrom(backgroundColor: Colors.green),
					// 		),
					// 	),
					// ),
			),
		);
	}
}