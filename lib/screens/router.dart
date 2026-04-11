import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:biom/screens/home.dart';
import 'package:biom/screens/photo.dart';
import 'package:biom/screens/description.dart';
import 'package:biom/screens/processing.dart';
import 'package:biom/screens/report.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    restorationScopeId: 'router',
    routes: [
      GoRoute( path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute( path: '/photo', builder: (context, state) => const PhotoScreen()),
      GoRoute( path: '/description', builder: (context, state) => const DescriptionScreen() ),
      GoRoute( path: '/processing', builder: (context, state) => const ProcessingScreen()),
      GoRoute( path: '/report/:id', builder: (context, state) => ReportScreen(reportID: state.pathParameters['id']!),),
    ],
  );
});