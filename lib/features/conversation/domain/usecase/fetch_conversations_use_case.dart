import 'package:convo_sphere/features/conversation/domain/entities/conversation_entity.dart';
import 'package:convo_sphere/features/conversation/domain/repositories/conversations_repository.dart';

class FetchConversationsUseCase {
  FetchConversationsUseCase({required this.repository});

  final ConversationsRepository repository;

  Future<List<ConversationEntity>> call() async {
    return await repository.fetchConversations();
  }
}
