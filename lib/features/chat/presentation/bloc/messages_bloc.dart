import 'dart:async';
import 'dart:developer';

import 'package:convo_sphere/core/services/socket_service.dart';
import 'package:convo_sphere/features/chat/domain/entities/daily_question_entity.dart';
import 'package:convo_sphere/features/chat/domain/entities/message_entity.dart';
import 'package:convo_sphere/features/chat/domain/usecase/fetch_daily_question_use_case.dart';
import 'package:convo_sphere/features/chat/domain/usecase/fetch_messages_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc({
    required this.messagesUseCase,
    required this.dailyQuestionUseCase,
  }) : super(MessagesInitial()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
    on<LoadDailyQuestionEvent>(_onLoadDailyQuestion);
  }

  final _storage = const FlutterSecureStorage();
  final _socketService = SocketService();

  final FetchMessagesUseCase messagesUseCase;
  final FetchDailyQuestionUseCase dailyQuestionUseCase;

  final List<MessageEntity> _messages = [];

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<MessagesState> emit,
  ) async {
    emit(MessageLoadingState());

    try {
      final messages = await messagesUseCase.call(event.conversationId);

      if (messages.isNotEmpty) {
        _messages.clear();
        _messages.addAll(messages);
        emit(MessageLoadedState(List.from(_messages)));

        _socketService.socket.off('newMessage');

        _socketService.socket.emit('joinConversation', event.conversationId);
        _socketService.socket.on(
          'newMessage',
          (data) {
            log('- step1 - receive: $data');
            add(ReceiveMessageEvent(data));
          },
        );
      } else {
        emit(MessagesErrorState('Failed to load message'));
      }
    } catch (e) {
      emit(MessagesErrorState('Failed to load message'));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<MessagesState> emit,
  ) async {
    String userId = await _storage.read(key: 'userId') ?? '';

    final newMessage = {
      'conversationId': event.conversationId,
      'senderId': userId,
      'content': event.content,
    };

    _socketService.socket.emit('sendMessage', newMessage);
  }

  FutureOr<void> _onReceiveMessage(
    ReceiveMessageEvent event,
    Emitter<MessagesState> emit,
  ) {
    log('- step2 - receive event called');

    final message = MessageEntity(
      id: event.messages['id'],
      conversationId: event.messages['conversation_id'],
      senderId: event.messages['sender_id'],
      content: event.messages['content'],
      createdAt: DateTime.parse(event.messages['created_at']),
    );

    _messages.add(message);
    emit(MessageLoadedState(List.from(_messages)));
  }

  Future<void> _onLoadDailyQuestion(
    LoadDailyQuestionEvent event,
    Emitter<MessagesState> emit,
  ) async {
    try {
      emit(MessageLoadingState());

      final dailyQuestion = await dailyQuestionUseCase.call(
        event.conversationId,
      );

      emit(DailyQuestionLoadedSate(dailyQuestion));
    } catch (e) {
      emit(MessagesErrorState('Failed to load daily question'));
    }
  }
}
