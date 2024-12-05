import 'package:convo_sphere/core/theme.dart';
import 'package:convo_sphere/features/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:convo_sphere/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:convo_sphere/features/authentication/domain/repositories/auth_repository.dart';
import 'package:convo_sphere/features/authentication/domain/usecases/login_use_case.dart';
import 'package:convo_sphere/features/authentication/domain/usecases/register_use_case.dart';
import 'package:convo_sphere/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:convo_sphere/features/chat/presentation/ui/chat_page.dart';
import 'package:convo_sphere/features/messages/presentation/ui/messages_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/ui/login_page.dart';
import 'features/authentication/presentation/ui/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = AuthRepositoryImpl(dataSource: AuthRemoteDataSource());

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authRepository),
            loginUseCase: LoginUseCase(repository: authRepository),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ConvoSphere',
        theme: AppTheme.darkTheme,
        home: const RegisterPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/messages': (_) => const MessagesPage(),
          '/chat': (_) => const ChatPage(),
        },
      ),
    );
  }
}
