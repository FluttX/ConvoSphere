import 'package:convo_sphere/features/conversation/domain/repositories/conversations_repository.dart';

class CheckOrCreateConversationUseCase {
  CheckOrCreateConversationUseCase({required this.repository});

  final ConversationsRepository repository;

  Future<String> call(String contactId) async {
    return await repository.checkOrCreateConversation(contactId);
  }
}
