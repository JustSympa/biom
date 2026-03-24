import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'state.dart';

// This provider will handle the sequence: GPS -> AI API
final diagnosisLogicProvider = FutureProvider<String>((ref) async {
	final imagePath = ref.watch(selectedImagePathProvider);
	final type = ref.watch(diagnosisTypeProvider);

	if (imagePath == null) throw Exception("No image found");

	// 1. Collect GPS Data
	// Placeholder for permissions check (should be done before this screen)
	Position position = await Geolocator.getCurrentPosition(locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

	// 2. Prepare the AI Prompt (Placeholders)
	final String gpsInfo = "Lat: ${position.latitude}, Long: ${position.longitude}";
	final String prompt = type == 'simple' 
			? "Analyze this plant image at $gpsInfo..." 
			: "Start advanced diagnosis for plant at $gpsInfo...";

	// 3. AI API Call Placeholder
	// Here is where you will eventually use the 'openai_dart' library
	await Future.delayed(const Duration(seconds: 3)); // Simulating network latency

	// Return the Markdown report
	return "# Diagnosis Report\n\nYour plant looks healthy, but needs more water. GPS: $gpsInfo";
});