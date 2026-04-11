// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../state/global.dart';

class PhotoScreen extends ConsumerWidget {
  const PhotoScreen({super.key});

  Future<void> _pickImage(ImageSource source, BuildContext context, WidgetRef ref) async {
    final inpuState = ref.read(diagnosisInputProvider);
    final inputStateNotifier = ref.read(diagnosisInputProvider.notifier);
		try {
      final picker = ImagePicker();
			final image = await picker.pickImage(source: source);
      if(image == null) return;
      if (inpuState.fullPic.isEmpty) inputStateNotifier.setFullPicture(image.path);
      else {
        inputStateNotifier.setSymptomPicture(image.path);
        context.pop(); context.push('/description');
      }
		} catch (e) {
			debugPrint("Error taking picture: $e");
		}
	}

	@override
	Widget build(BuildContext context, WidgetRef ref) {
    final inputState = ref.watch(diagnosisInputProvider);
    final colors = Theme.of(context).colorScheme;

		return Scaffold(
			appBar: AppBar(
        backgroundColor: colors.primaryContainer,
				title: Row(
          spacing: 12,
          children: [
            Icon(Icons.image, size: 36, color: colors.primary ),
            Text('Select Images', style: TextStyle(color: colors.primary),)
          ],
        ),
			),
			body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 24.0,
            children: [
              Text(
                inputState.fullPic.isEmpty ?
                'Select Full Picture' :
                'Select Symptom Picture',
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                inputState.fullPic.isEmpty ?
                'This picture will be used to identify the particular plant.' :
                'This picture will be used to identify whether or not your plant is diseased.',
                softWrap: true,
                style: const TextStyle(
                  color: Colors.grey
                ),
              ),
              GestureDetector(
                onTap: () { _pickImage(ImageSource.gallery, context, ref); },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    spacing: 24,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.browse_gallery, color: colors.primary, size: 16,),
                      Text('From Gallery', style: TextStyle(color: colors.primary),)
                    ],
                  ),
                )
              ),
              GestureDetector(
                onTap: () { _pickImage(ImageSource.camera, context, ref); },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    spacing: 24,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.camera, color: colors.primary, size: 16,),
                      Text('From Camera', style: TextStyle(color: colors.primary),)
                    ],
                  ),
                )
              )
            ],
          ),
        )
      )
		);
	}
}