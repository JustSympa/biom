import 'package:flutter_riverpod/flutter_riverpod.dart';

// This stores the path of the captured image
class SelectedImageNotifier extends Notifier<String?> { @override String? build () => null; }
final selectedImagePathProvider = NotifierProvider(SelectedImageNotifier.new);

// This stores whether the user chose 'simple' or 'advanced'
class DiagnosisTypeNotifier extends Notifier { @override String build () => 'simple'; }
final diagnosisTypeProvider = NotifierProvider(DiagnosisTypeNotifier.new);