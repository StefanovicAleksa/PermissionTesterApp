import 'package:go_router/go_router.dart';
import 'package:permission_tester_app/core/widgets/coming_soon.dart';
import 'package:permission_tester_app/features/camera/presentation/pages/camera_page.dart';
import 'package:permission_tester_app/features/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/camera',
        builder: (context, state) => const CameraPage(),
      ),
      GoRoute(
        path: '/coming-soon',
        builder: (context, state) => const ComingSoonPage(),
      ),
    ],
  );
}