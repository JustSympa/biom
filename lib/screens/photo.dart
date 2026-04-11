// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biom/models/diagnosis.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../state/global.dart';

class PhotoScreen extends ConsumerStatefulWidget {
	const PhotoScreen({super.key});

	@override
	ConsumerState<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends ConsumerState<PhotoScreen> {
	CameraController? _controller;
	Future<void>? _initializeControllerFuture;
  

	@override
	void initState() {
		super.initState();
		_setupCamera();
	}

	Future<void> _setupCamera() async {
		final cameras = await availableCameras();
		_controller = CameraController(cameras.first, ResolutionPreset.medium, enableAudio: false);
		setState(() { _initializeControllerFuture = _controller!.initialize(); });
	}

	@override
	void dispose() { _controller?.dispose(); super.dispose(); }

	Future<void> _takePicture() async {
    final inpuState = ref.read(diagnosisInputProvider);
    final inputStateNotifier = ref.read(diagnosisInputProvider.notifier);
		try {
			await _initializeControllerFuture;
			final image = await _controller!.takePicture();
      if (inpuState.fullPic.isEmpty) inputStateNotifier.setFullPicture(image.path);
      else inputStateNotifier.setSymptomPicture(image.path);

			if (mounted && inpuState.symptomPic.isNotEmpty) {
        context.pop(); context.push('description');
      }
		} catch (e) {
			debugPrint("Error taking picture: $e");
		}
	}

  Future<void> _pickImage() async {
    final inpuState = ref.read(diagnosisInputProvider);
    final inputStateNotifier = ref.read(diagnosisInputProvider.notifier);
		try {
      final picker = ImagePicker();
			final image = await picker.pickImage(source: ImageSource.gallery);
      if(image == null) return;
      if (inpuState.fullPic.isEmpty) inputStateNotifier.setFullPicture(image.path);
      else inputStateNotifier.setSymptomPicture(image.path);

			if (mounted && inpuState.symptomPic.isNotEmpty) {
        context.pop(); context.push('description');
      }
		} catch (e) {
			debugPrint("Error taking picture: $e");
		}
	}

	@override
	Widget build(BuildContext context) {
    final inputState = ref.watch(diagnosisInputProvider);

		return Scaffold(
			backgroundColor: Colors.black,
			appBar: AppBar(
        actions: [
          IconButton(onPressed: _pickImage, icon: const Icon(Icons.folder))
        ],
				title: Text(inputState.fullPic.isEmpty ? "Full Picture" : "Symptom Picture"),
				backgroundColor: Color(0x7F000000),
				foregroundColor: Colors.white,
			),
			body: FutureBuilder<void>(
				future: _initializeControllerFuture,
				builder: (context, snapshot) {
					if (snapshot.connectionState == ConnectionState.done) {
						return Stack(
							children: [
								Center(child: CameraPreview(_controller!)),
								Align(
									alignment: Alignment.bottomCenter,
									child: Padding(
										padding: const EdgeInsets.only(bottom: 30),
										child: FloatingActionButton.large(
											onPressed: _takePicture,
											backgroundColor: Colors.white,
											child: const Icon(Icons.camera, color: Colors.black),
										),
									),
								),
							],
						);
					} else {
						return const Center(child: CircularProgressIndicator());
					}
				},
			),
		);
	}
}