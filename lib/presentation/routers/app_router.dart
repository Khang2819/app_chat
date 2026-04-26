// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../domain/repositories/user_entity.dart';
import '../screens/add_friend_qr_screen.dart';
import '../screens/change_password.dart';
import '../screens/chats_screen.dart';
import '../screens/directory.dart';
import '../screens/forgot_password.dart';
import '../screens/friendrequestscreen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/qr_scan_screen.dart';
import '../screens/register_screen.dart';
import '../screens/search_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/story_screen.dart';
import '../screens/user_info_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isLogin = user != null;
      final isGoingToLogin = state.matchedLocation == '/login';
      if (!isLogin && !isGoingToLogin) {
        return '/login';
      }

      if (isLogin && isGoingToLogin) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => Register()),
      GoRoute(path: '/forgot', builder: (context, state) => ForgotPassword()),
      GoRoute(path: '/mainScreen', builder: (context, state) => Mainscreen()),
      GoRoute(path: '/directory', builder: (context, state) => Directory()),
      GoRoute(path: '/setting', builder: (context, state) => Setting()),
      GoRoute(path: '/story', builder: (context, state) => StoryScreen()),
      GoRoute(
        path: '/friendrequest',
        builder: (context, state) => Friendrequestscreen(),
      ),
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
      GoRoute(
        path: '/userinfo',
        builder: (context, state) {
          final userId = state.extra as String;
          return UserInfoScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) {
          final user = state.extra as UserEntity; // Nhận UserEntity truyền sang
          return Chats(receiver: user);
        },
      ),
    ],
  );
}
