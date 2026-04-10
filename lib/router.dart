import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home.dart';
import 'screens/photo.dart';
import 'screens/simple/processing.dart';
import 'screens/report.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    restorationScopeId: 'router',
    routes: [
      GoRoute( path: '/',             builder: (context, state) => HomeScreen()),
      GoRoute( path: '/photo/:type',  builder: (context, state) => PhotoScreen(type: state.pathParameters['type']!),),
      GoRoute( path: '/processing/simple',   builder: (context, state) => ProcessingScreen(),),
      GoRoute( path: '/report/:id',   builder: (context, state) => ReportScreen(reportID: state.pathParameters['id']!),),
    ],
);
});