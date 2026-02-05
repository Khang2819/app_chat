import 'package:app_chat/domain/usecases/auth_usecases/logout_usecase.dart';
import 'package:app_chat/presentation/blocs/home/home_bloc.dart';
import 'package:app_chat/presentation/blocs/home/home_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/auth_remote_datasource.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/auth_usecases/login_usecase.dart';
import 'domain/usecases/auth_usecases/register_usecase.dart';
import 'firebase_options.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/routers/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authDataSource = AuthRemoteDataSourceImpl();
  final userDataSource = UserRemoteDatasourceImpl();
  final authRepository = AuthRepositoryImpl(authDataSource);
  final userRepository = UserRepositoryImpl(userDataSource);
  final loginUseCase = LoginUsecase(authRepository);
  final registerUseCase = RegisterUsecase(authRepository);
  final logoutUsecase = LogoutUsecase(authRepository);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(
                loginUseCase: loginUseCase,
                registerUsecase: registerUseCase,
                logoutUsecase: logoutUsecase,
              ),
        ),
        BlocProvider(
          create:
              (_) => HomeBloc(userRepository: userRepository)..add(HomeLoad()),
        ),
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
      routerConfig: AppRouter.router,
    );
  }
}
