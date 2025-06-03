import 'package:go_router/go_router.dart';

import '../../features/auth/screens/home_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/splash_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: SplashScreen.route,
    routes: [
      GoRoute(path: SplashScreen.route, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RegisterScreen.route, builder: (context, state) => const RegisterScreen()),
      GoRoute(path: LoginScreen.route, builder: (context, state) => const LoginScreen()),
      GoRoute(path: HomeScreen.route, builder: (context, state) => const HomeScreen()),
    ],
  );
}
