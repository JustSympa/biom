import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen.dart';
import 'photo_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
	return GoRouter(
		initialLocation: '/',
		routes: [
			GoRoute(
				path: '/',
				builder: (context, state) => const HomeScreen(),
			),
			GoRoute(
				path: '/photo/:type', // 'simple' or 'advanced'
				builder: (context, state) => PhotoScreen(
					type: state.pathParameters['type']!,
				),
			),
			// GoRoute(
			// 	path: '/processing',
			// 	builder: (context, state) => const ProcessingScreen(),
			// ),
			// GoRoute(
			// 	path: '/report',
			// 	builder: (context, state) => const ReportScreen(),
			// ),
		],
	);
});