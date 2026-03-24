import 'package:flutter/material.dart';
import 'router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
    runApp(const ProviderScope(child: Biom()));
}

class Biom extends ConsumerWidget {
	const Biom({super.key});

	@override
  	Widget build(BuildContext context, WidgetRef ref) {
		final router = ref.watch(routerProvider);
		return MaterialApp.router(
			title: 'Biom',
			theme: ThemeData(
				useMaterial3: true,
        		colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F904B)),
			),
			routerConfig: router,
		);
	}
}