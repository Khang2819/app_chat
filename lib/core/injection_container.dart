import 'package:app_chat/domain/repositories/friend_repository.dart';
import 'package:app_chat/presentation/blocs/auth/auth_bloc.dart';
import 'package:app_chat/presentation/blocs/friend/friend_bloc.dart';
import 'package:app_chat/presentation/blocs/home/home_bloc.dart';
import 'package:app_chat/presentation/blocs/my_qr/my_qr_bloc.dart';
import 'package:app_chat/presentation/blocs/search/search_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/auth_remote_datasource.dart';
import '../data/datasources/chat_remote_datasource.dart';
import '../data/datasources/friend_remote_datasource.dart';
import '../data/datasources/user_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/chat_repository_impl.dart';
import '../data/repositories/friend_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/usecases/auth_usecases/login_usecase.dart';
import '../domain/usecases/auth_usecases/logout_usecase.dart';
import '../domain/usecases/auth_usecases/register_usecase.dart';
import '../domain/usecases/chat_usecases.dart';
import '../domain/usecases/friend_usecases.dart';
import '../presentation/blocs/chat/chat_bloc.dart';

final getIt = GetIt.instance;
void init() {
  // bloc
  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt(),
      registerUsecase: getIt(),
      logoutUsecase: getIt(),
    ),
  );
  getIt.registerFactory(() => SearchBloc(userRepository: getIt()));
  getIt.registerFactory(() => HomeBloc(userRepository: getIt()));
  getIt.registerFactory(
    () => FriendBloc(
      sendFriendRequestUsecase: getIt(),
      acceptFriendRequestUsecase: getIt(),
      deleteFriendRequestUsecase: getIt(),
      getIncomingRequestsUsecase: getIt(),
    ),
  );
  getIt.registerFactory(() => MyQrBloc(userRepository: getIt()));
  getIt.registerFactory(
    () => ChatBloc(getChatUsecase: getIt(), sendChatUsecase: getIt()),
  );

  //case
  getIt.registerLazySingleton(() => LoginUsecase(getIt()));
  getIt.registerLazySingleton(() => RegisterUsecase(getIt()));
  getIt.registerLazySingleton(() => LogoutUsecase(getIt()));
  getIt.registerLazySingleton(() => SendFriendRequestUsecase(getIt()));
  getIt.registerLazySingleton(() => AcceptFriendRequestUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteFriendRequestUsecase(getIt()));
  getIt.registerLazySingleton(() => GetIncomingRequestsUsecase(getIt()));
  getIt.registerLazySingleton(() => GetChatUsecase(getIt()));
  getIt.registerLazySingleton(() => SendChatUsecase(getIt()));

  //Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<FriendRepository>(
    () => FriendRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(getIt()),
  );

  //Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(),
  );
  getIt.registerLazySingleton<FriendRemoteDatasource>(
    () => FriendRemoteDatasourceImpl(),
  );
  getIt.registerLazySingleton<ChatRemoteDatasource>(
    () => ChatRemoteDatasourceImpl(),
  );
}
