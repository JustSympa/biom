// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:biom/models/diagnosis.dart';
import 'package:biom/state/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class DiagnosisBriefWidget extends ConsumerStatefulWidget {
  final DiagnosisMeta diag;
  const DiagnosisBriefWidget({super.key, required this.diag});

  @override
  ConsumerState<DiagnosisBriefWidget> createState() => _DiagnosisBriefWidgetState();
}

class _DiagnosisBriefWidgetState extends ConsumerState<DiagnosisBriefWidget> {
  late Future<String?> _imageURLFuture;

  @override
  void initState() {
    super.initState();
    _imageURLFuture = _getImageURL();
  }

  IconData iconFromState(String state) {
    if(state == 'healthy') return Icons.health_and_safety;
    else if(state == 'diseased') return Icons.dangerous;
    else if (state == 'stressed') return Icons.warning;
    else return Icons.question_mark;
  }

  Future<String?> _getImageURL() async {
    final doc = await getApplicationDocumentsDirectory();
    final files = Directory('${doc.path}/reports/${widget.diag.id}').listSync();
    for(var f in files) {
      if(f.path.contains('image.')) return f.path;
    }
    return null;
  }

  void _showDeletionDialog(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final diagnosisHistory = ref.read(diagnosisHistoryProvider.notifier);
    
		showDialog(
			context: context,
			builder: (context) => SimpleDialog(
				title: Text('Confirmation', style: TextStyle(fontWeight: FontWeight.w600),),
        contentPadding: const EdgeInsetsGeometry.all(16),
				children: [
          const Text(
            'Are you sure you want to delete this diagnosis ?',
            softWrap: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  context.pop(); // Close dialog
                  diagnosisHistory.deleteDiagnosis(widget.diag.id);
                },
                child: Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: colors.primary),),
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

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onLongPress: () {
        
      },
      onTap: () {
        context.push('/report/${widget.diag.id}');
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 12.0,
          children: [
            FutureBuilder<String?>(
              future: _imageURLFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.file(
                      File(snapshot.data!),
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Icon(
                    iconFromState(widget.diag.healthStatus),
                    size: 64.0,
                  );
                } else {
                  return const SizedBox(
                    width: 64,
                    height: 64,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.0,
                children: [
                  Text('${widget.diag.plantName!.substring(0, 36)}...', textScaler: const TextScaler.linear(1.25), style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold),),
                  Text(widget.diag.createdAt.toString(), style: const TextStyle( color: Colors.grey),)
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                size: 32,
                color: colors.tertiary,
              ),
              onPressed: () => _showDeletionDialog(context),
            )
          ],
        )
      )
    );
  }
}