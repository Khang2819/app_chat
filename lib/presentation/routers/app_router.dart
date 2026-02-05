import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../screens/add_friend_qr_screen.dart';
import '../screens/change_password.dart';
import '../screens/chats_screen.dart';
import '../screens/directory.dart';
import '../screens/forgot_password.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/qr_scan_screen.dart';
import '../screens/register_screen.dart';
import '../screens/search_screen.dart';
import '../screens/setting_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final currentUser = FirebaseAuth.instance.currentUser;
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/forgot';
      if (currentUser == null && !isAuthRoute) {
        return '/login';
      }
      if (currentUser != null && isAuthRoute) {
        return '/mainScreen';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => Register()),
      GoRoute(path: '/forgot', builder: (context, state) => ForgotPassword()),
      GoRoute(path: '/mainScreen', builder: (context, state) => Mainscreen()),
      GoRoute(path: '/chat', builder: (context, state) => Chats()),
      GoRoute(path: '/directory', builder: (context, state) => Directory()),
      GoRoute(path: '/setting', builder: (context, state) => Setting()),
      GoRoute(
        path: '/change_password',
        builder: (context, state) => ChangePassword(),
      ),
      GoRoute(path: '/search', builder: (context, state) => SearchScreen()),
      GoRoute(
        path: '/qr_screen',
        builder: (context, state) => AddFriendQrScreen(),
      ),
      GoRoute(path: '/qr_scan', builder: (context, state) => QrScanScreen()),
    ],
  );
}
