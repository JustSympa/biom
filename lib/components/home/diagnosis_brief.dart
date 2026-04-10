// ignore_for_file: non_constant_identifier_names

import 'package:biom/models/diagnosis_meta.dart';
import 'package:biom/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class DiagnosisbriefWidget extends StatelessWidget {
  final DiagnosisMeta diag;
  const DiagnosisbriefWidget({super.key, required this.diag});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        context.push('report/${diag.id}');
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        color: Palette.col300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(diag.plantName!, textScaler: TextScaler.linear(2.0),),
            Text(diag.createdAt.toString(), style: TextStyle( color: Colors.grey),)
          ],
        ),
      )
    );
  }
}