import 'package:app_chat/core/injection_container.dart';
import 'package:app_chat/presentation/blocs/home/home_bloc.dart';
import 'package:app_chat/presentation/blocs/home/home_event.dart';
import 'package:app_chat/presentation/blocs/my_qr/my_qr_bloc.dart';
import 'package:app_chat/presentation/blocs/search/search_bloc.dart';
import 'package:app_chat/presentation/cubits/LoginCubit/login_cubit.dart';
import 'package:app_chat/presentation/cubits/RegisterCubit/register_cubit.dart';
import 'package:app_chat/presentation/cubits/cubit/forgot_password_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/auth/auth_event.dart';
import 'presentation/blocs/friend/friend_bloc.dart';
import 'presentation/routers/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(AuthStatusChanged(null)),
        ),
        BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => getIt<RegisterCubit>()),
        BlocProvider(create: (_) => getIt<ForgotPasswordCubit>()),
        BlocProvider(create: (_) => getIt<HomeBloc>()..add(HomeLoad())),
        BlocProvider(create: (_) => getIt<SearchBloc>()),
        BlocProvider(create: (_) => getIt<FriendBloc>()),
        BlocProvider(create: (_) => getIt<MyQrBloc>()..add(LoadMyQrInfo())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'app_chat',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.createRouter(context.read<AuthBloc>()),
    );
  }
}
