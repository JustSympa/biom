import 'package:biom/kv/kv.dart';
import 'package:biom/palette.dart';
import 'package:flutter/material.dart';
import 'router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await KVS.init();
  

  FlutterNativeSplash.remove();
	runApp(ProviderScope(child: Biom()));
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
					colorScheme: ColorScheme.fromSeed(seedColor: Palette.col500),
			),
			routerConfig: router,
		);
	}
}