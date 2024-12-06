import 'package:convo_sphere/features/conversation/data/datasource/remote/conversation_remote_data_source.dart';
import 'package:convo_sphere/features/conversation/domain/entities/conversation_entity.dart';
import 'package:convo_sphere/features/conversation/domain/repositories/conversations_repository.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  ConversationsRepositoryImpl({required this.dataSource});

  final ConversationRemoteDataSource dataSource;

  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await dataSource.fetchConversations();
  }
}