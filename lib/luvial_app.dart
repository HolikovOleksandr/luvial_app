import 'package:flutter/material.dart';
import 'package:luvial_app/core/router/app_router.dart';

class LuvialApp extends StatelessWidget {
  const LuvialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Luvial App',
      routerConfig: AppRouter.router,
    );
  }
}
