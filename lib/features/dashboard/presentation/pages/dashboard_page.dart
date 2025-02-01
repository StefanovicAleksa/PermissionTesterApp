import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_tester_app/core/constants/app_constants.dart';
import 'package:permission_tester_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:permission_tester_app/features/dashboard/presentation/widgets/feature_tile.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          FeatureTile(
            title: AppConstants.cameraFeature,
            icon: Icons.camera_alt,
            onTap: () => context.go(AppConstants.cameraRoute),
          ),
          FeatureTile(
            title: AppConstants.comingSoonFeature,
            icon: Icons.upcoming,
            onTap: () => context.go(AppConstants.comingSoonRoute),
          ),
        ],
      ),
    );
  }
}