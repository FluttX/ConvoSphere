part of 'messages_bloc.dart';

abstract class MessagesEvent {}

class LoadMessagesEvent extends MessagesEvent {
  LoadMessagesEvent(this.conversationId);

  final String conversationId;
}

class SendMessageEvent extends MessagesEvent {
  SendMessageEvent(this.conversationId, this.content);

  final String conversationId;
  final String content;
}

class ReceiveMessageEvent extends MessagesEvent {
  ReceiveMessageEvent(this.messages);

  final Map<String, dynamic> messages;
}

class LoadDailyQuestionEvent extends MessagesEvent {
  LoadDailyQuestionEvent(this.conversationId);

  final String conversationId;
}
