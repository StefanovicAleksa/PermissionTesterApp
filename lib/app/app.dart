import 'package:flutter/material.dart';
import 'package:permission_tester_app/app/router.dart';
import 'package:permission_tester_app/core/theme/app_theme.dart';

class PermissionTesterApp extends StatelessWidget {
  const PermissionTesterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Permission Tester',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}