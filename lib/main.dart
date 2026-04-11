import 'package:biom/services/api.dart';
import 'package:biom/services/kv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:biom/screens/router.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
  await dotenv.load(fileName: ".env.$env");
  await KVS.init();
  // await KVS.reset();
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
      debugShowCheckedModeBanner: false,
			theme: ThemeData(
				useMaterial3: true,
				colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff3c8137)),
			),
			routerConfig: router,
		);
	}
}