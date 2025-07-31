import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/views/login_screen.dart';
import '../../modules/dashboard/views/dashboard_screen.dart';
import '../../modules/users/views/user_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    final isLoggingIn = state.matchedLocation == '/';

    if (!isLoggedIn && !isLoggingIn) {
      return '/';
    }

    if (isLoggedIn && isLoggingIn) {
      return '/dashboard';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (_, __) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/user/:id',
      name: 'user_detail',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return UserDetailScreen(userId: id!);
      },
    ),
  ],
);
