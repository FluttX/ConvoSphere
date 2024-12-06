class ConversationEntity {
  ConversationEntity({
    required this.id,
    required this.participantName,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  final String id;
  final String participantName;
  final String lastMessage;
  final DateTime lastMessageTime;
}
