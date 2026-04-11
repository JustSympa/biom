// ignore_for_file: non_constant_identifier_names

import 'package:biom/models/diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DiagnosisbriefWidget extends StatelessWidget {
  final DiagnosisMeta diag;
  const DiagnosisbriefWidget({super.key, required this.diag});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        context.push('report/${diag.id}');
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        color: colors.primaryContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(diag.plantName!, textScaler: const TextScaler.linear(2.0),),
            Text(diag.createdAt.toString(), style: const TextStyle( color: Colors.grey),)
          ],
        ),
      )
    );
  }
}