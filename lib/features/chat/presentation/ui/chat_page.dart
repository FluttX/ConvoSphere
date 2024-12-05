import 'package:convo_sphere/features/chat/presentation/widgets/message_input.dart';
import 'package:convo_sphere/features/chat/presentation/widgets/receive_message.dart';
import 'package:convo_sphere/features/chat/presentation/widgets/send_message.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
              'Md. Al-amin',
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
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                ReceiveMessageWidget(
                  message: 'Hey! How have you been?',
                ),
                SendMessageWidget(
                  message: 'I’m good, thanks! How about you?',
                ),
                ReceiveMessageWidget(
                  message: 'Did you complete the assignment?',
                ),
                SendMessageWidget(
                  message: 'Yes, I sent it to you yesterday.',
                ),
                ReceiveMessageWidget(
                  message: 'Are we meeting at the usual spot?',
                ),
                SendMessageWidget(
                  message: 'Yes, 5 PM works for me.',
                ),
                ReceiveMessageWidget(
                  message: 'Can you help me with this bug?',
                ),
                SendMessageWidget(
                  message: 'Sure, share the code with me.',
                ),
                ReceiveMessageWidget(
                  message: 'What are your plans for the weekend?',
                ),
                SendMessageWidget(
                  message: 'I’m thinking of going hiking. You?',
                ),
              ],
            ),
          ),
          const MessageInputWidget(),
        ],
      ),
    );
  }
}
