// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:app_chat/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/user_entity.dart';
import '../blocs/auth/auth_state.dart';
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

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static GoRouter createRouter(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: '/splash',
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      redirect: (context, state) {
        final auth = authBloc.state;
        final isSplash = state.matchedLocation == '/splash';
        final authRoute =
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/forgot';

        if (auth is AuthInitial || auth is AuthLoading) {
          return isSplash ? null : '/splash';
        }

        if (auth is AuthUnauthenticated) {
          return authRoute ? null : '/login';
        }

        if (auth is AuthAuthenticated) {
          if (authRoute || isSplash) return '/mainScreen';
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
            final user =
                state.extra as UserEntity; // Nhận UserEntity truyền sang
            return Chats(receiver: user);
          },
        ),
      ],
    );
  }
}
