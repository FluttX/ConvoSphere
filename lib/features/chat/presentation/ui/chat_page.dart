import 'package:convo_sphere/features/chat/presentation/bloc/messages_bloc.dart';
import 'package:convo_sphere/features/chat/presentation/widgets/message_input.dart';
import 'package:convo_sphere/features/chat/presentation/widgets/receive_message.dart';
import 'package:convo_sphere/features/chat/presentation/widgets/send_message.dart';
import 'package:convo_sphere/features/conversation/presentation/widgets/no_conversation_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.name, required this.conversationId});

  final String name;
  final String conversationId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  String userId = '';

  void fetchUserId() async {
    userId = await _storage.read(key: 'userId') ?? '';
    setState(() {});
  }

  void _sendMessage() {
    final content = _messageController.text.trim();

    if (content.isNotEmpty) {
      BlocProvider.of<MessagesBloc>(context).add(
        SendMessageEvent(widget.conversationId, content),
      );
      _messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessagesBloc>(context).add(
      LoadMessagesEvent(widget.conversationId),
    );

    fetchUserId();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/1.jpg',
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is MessageLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is MessageLoadedState) {
                  if (state.messages.isEmpty) {
                    return const NoConversationFound();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isSendMessage = message.senderId == userId;
                      if (isSendMessage) {
                        return SendMessageWidget(message: message.content);
                      } else {
                        return ReceiveMessageWidget(message: message.content);
                      }
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
          MessageInputWidget(
            controller: _messageController,
            onSendPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
