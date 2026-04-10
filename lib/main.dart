import 'package:biom/api/api.dart';
import 'package:biom/kv/kv.dart';
import 'package:biom/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
  await dotenv.load(fileName: ".env.$env");
  await KVS.init();
  if(!KVS.hasUser) {
    API.init('');
    final refreshToken = await API.initUser();
    KVS.refreshToken = refreshToken;
    API.init(refreshToken);
  } else {
    API.init(KVS.refreshToken!);
  }

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