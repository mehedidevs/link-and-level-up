import 'package:flutter/material.dart';

import 'config/routes/app_routes.dart';
import 'config/routes/on_generate_route.dart';
import 'config/themes/app_themes.dart';
import 'features/auth/presentation/pages/start_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.defaultTheme,
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.StartScreen,
      home: const StartScreen(),
    );
  }
}
