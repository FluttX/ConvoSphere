import 'package:convo_sphere/core/theme.dart';
import 'package:convo_sphere/features/chat/presentation/ui/chat_page.dart';
import 'package:convo_sphere/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:convo_sphere/features/conversation/presentation/widgets/message_tile.dart';
import 'package:convo_sphere/features/conversation/presentation/widgets/no_conversation_found.dart';
import 'package:convo_sphere/features/conversation/presentation/widgets/recent_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ConversationsBloc>(context).add(FetchConversationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Recent',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                RecentContactWidget(
                  name: 'Alice Johnson',
                  imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
                ),
                RecentContactWidget(
                  name: 'Bob Smith',
                  imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                ),
                RecentContactWidget(
                  name: 'Charlie Brown',
                  imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
                ),
                RecentContactWidget(
                  name: 'Diana Prince',
                  imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
                ),
                RecentContactWidget(
                  name: 'Edward Norton',
                  imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
                ),
                RecentContactWidget(
                  name: 'Fiona Gallagher',
                  imageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state) {
                  if (state is ConversationsLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is ConversationsLoaded) {
                    final conversations = state.conversations;

                    if (conversations.isEmpty) {
                      return const NoConversationFound();
                    }

                    return ListView.builder(
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        return MessageTileWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatPage(
                                  name: conversations[index].participantName,
                                  conversationId: conversations[index].id,
                                ),
                              ),
                            );
                          },
                          name: conversations[index].participantName,
                          imageUrl:
                              'https://randomuser.me/api/portraits/men/1.jpg',
                          message: conversations[index].lastMessage,
                          time: conversations[index].lastMessageTime,
                        );
                      },
                    );
                  } else if (state is ConversationsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
