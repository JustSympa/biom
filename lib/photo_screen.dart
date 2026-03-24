import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'state.dart';

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
		final firstCamera = cameras.first;
		
		_controller = CameraController(
			firstCamera,
			ResolutionPreset.medium,
			enableAudio: false,
		);

		setState(() {
			_initializeControllerFuture = _controller!.initialize();
		});
		
		// Save the type (simple/advanced) to our global state
		ref.read(diagnosisTypeProvider.notifier).state = widget.type;
	}

	@override
	void dispose() {
		_controller?.dispose();
		super.dispose();
	}

	Future<void> _takePicture() async {
		try {
			await _initializeControllerFuture;
			final image = await _controller!.takePicture();

			// Save path to Riverpod state
			ref.read(selectedImagePathProvider.notifier).state = image.path;

			// Navigate to Processing
			if (mounted) context.push('/processing');
		} catch (e) {
			debugPrint("Error taking picture: $e");
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.black,
			appBar: AppBar(
				title: Text('${widget.type.toUpperCase()} Photo'),
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