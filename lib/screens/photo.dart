import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/state.dart';

class PhotoScreen extends ConsumerStatefulWidget {
	final String type;
	const PhotoScreen({super.key, required this.type});

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
		ref.read(diagnosisTypeProvider.notifier).state = widget.type;
	}

	@override
	void dispose() { _controller?.dispose(); super.dispose(); }

	Future<void> _takePicture() async {
		try {
			await _initializeControllerFuture;
			final image = await _controller!.takePicture();
			ref.read(selectedImagePathProvider.notifier).addImage(image.path);
			if (mounted) context.push('/processing/simple');
		} catch (e) {
			debugPrint("Error taking picture: $e");
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			appBar: AppBar(
				title: const Text('Photo'),
				backgroundColor: Colors.transparent,
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
										padding: EdgeInsets.only(bottom: 30),
										child: FloatingActionButton.large(
											onPressed: _takePicture,
											backgroundColor: Colors.white,
											child: Icon(Icons.camera, color: Colors.black),
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