import 'package:convo_sphere/core/services/socket_service.dart';
import 'package:convo_sphere/core/theme.dart';
import 'package:convo_sphere/features/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:convo_sphere/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:convo_sphere/features/authentication/domain/repositories/auth_repository.dart';
import 'package:convo_sphere/features/authentication/domain/usecases/login_use_case.dart';
import 'package:convo_sphere/features/authentication/domain/usecases/register_use_case.dart';
import 'package:convo_sphere/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:convo_sphere/features/chat/data/datasource/remote/messages_remote_data_source.dart';
import 'package:convo_sphere/features/chat/data/repositories/messages_repository_impl.dart';
import 'package:convo_sphere/features/chat/domain/usecase/fetch_messages_use_case.dart';
import 'package:convo_sphere/features/chat/presentation/bloc/messages_bloc.dart';
import 'package:convo_sphere/features/chat/presentation/ui/chat_page.dart';
import 'package:convo_sphere/features/contacts/data/datasource/remote/contacts_remote_data_source.dart';
import 'package:convo_sphere/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:convo_sphere/features/contacts/domain/repositories/contacts_repository.dart';
import 'package:convo_sphere/features/contacts/domain/usecase/add_contact_use_case.dart';
import 'package:convo_sphere/features/contacts/domain/usecase/fetch_contacts_use_case.dart';
import 'package:convo_sphere/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:convo_sphere/features/conversation/data/datasource/remote/conversation_remote_data_source.dart';
import 'package:convo_sphere/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:convo_sphere/features/conversation/domain/repositories/conversations_repository.dart';
import 'package:convo_sphere/features/conversation/domain/usecase/check_or_create_conversation_use_case.dart';
import 'package:convo_sphere/features/conversation/presentation/ui/conversations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/presentation/ui/login_page.dart';
import 'features/authentication/presentation/ui/register_page.dart';
import 'features/chat/domain/repositories/messages_repository.dart';
import 'features/conversation/domain/usecase/fetch_conversations_use_case.dart';
import 'features/conversation/presentation/bloc/conversations_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final socketService = SocketService();
  await socketService.initSocket();

  final authRepository = AuthRepositoryImpl(dataSource: AuthRemoteDataSource());
  final conversationRepository = ConversationsRepositoryImpl(
    remoteDataSource: ConversationRemoteDataSource(),
  );
  final messageRepository = MessagesRepositoryImpl(
    remoteDataSource: MessagesRemoteDataSource(),
  );
  final contactsRepository = ContactsRepositoryImpl(
    remoteDataSource: ContactsRemoteDataSource(),
  );

  runApp(MyApp(
    authRepository: authRepository,
    conversationRepository: conversationRepository,
    messagesRepository: messageRepository,
    contactsRepository: contactsRepository,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.authRepository,
    required this.conversationRepository,
    required this.messagesRepository,
    required this.contactsRepository,
  });

  final AuthRepository authRepository;
  final ConversationsRepository conversationRepository;
  final MessagesRepository messagesRepository;
  final ContactsRepository contactsRepository;

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
        BlocProvider(
          create: (_) => ConversationsBloc(
            conversationsUseCase: FetchConversationsUseCase(
              repository: conversationRepository,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => MessagesBloc(
            messagesUseCase: FetchMessagesUseCase(
              repository: messagesRepository,
            ),
          ),
        ),
        BlocProvider(
          create: (_) => ContactsBloc(
            fetchContactsUseCase: FetchContactsUseCase(
              repository: contactsRepository,
            ),
            addContactUseCase: AddContactUseCase(
              repository: contactsRepository,
            ),
            checkOrCreateConversationUseCase: CheckOrCreateConversationUseCase(
              repository: conversationRepository,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ConvoSphere',
        theme: AppTheme.darkTheme,
        home: const LoginPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/conversations': (_) => const ConversationsPage(),
          '/chat': (_) => const ChatPage(conversationId: '', name: ''),
        },
      ),
    );
  }
}
