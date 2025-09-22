import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/my_course1_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/my_course1',
  routes: [
    GoRoute(
      path: '/my_course1',
      builder: (BuildContext context, GoRouterState state) {
        return const MyCourse1Screen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
    );
  }
}
