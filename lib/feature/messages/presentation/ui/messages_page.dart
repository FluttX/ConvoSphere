import 'package:convo_sphere/core/theme.dart';
import 'package:convo_sphere/feature/messages/presentation/widgets/message_tile.dart';
import 'package:convo_sphere/feature/messages/presentation/widgets/recent_contact.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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
              child: ListView(
                children: const [
                  MessageTileWidget(
                    name: 'Alice Johnson',
                    imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
                    message: 'Hey, are you free this evening?',
                    time: '08:30 AM',
                  ),
                  MessageTileWidget(
                    name: 'Bob Smith',
                    imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                    message: 'Don’t forget the meeting tomorrow.',
                    time: '09:15 AM',
                  ),
                  MessageTileWidget(
                    name: 'Charlie Brown',
                    imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
                    message: 'Can you send me the report?',
                    time: '10:05 AM',
                  ),
                  MessageTileWidget(
                    name: 'Diana Prince',
                    imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
                    message: 'Great job on the project!',
                    time: '10:45 AM',
                  ),
                  MessageTileWidget(
                    name: 'Edward Norton',
                    imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
                    message: 'Let’s catch up soon.',
                    time: '11:20 AM',
                  ),
                  MessageTileWidget(
                    name: 'Fiona Gallagher',
                    imageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
                    message: 'Can you share the notes?',
                    time: '12:00 PM',
                  ),
                  MessageTileWidget(
                    name: 'George Harrison',
                    imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
                    message: 'I’m working on the updates.',
                    time: '01:15 PM',
                  ),
                  MessageTileWidget(
                    name: 'Hannah Montana',
                    imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
                    message: 'When is our next team call?',
                    time: '02:30 PM',
                  ),
                  MessageTileWidget(
                    name: 'Isaac Newton',
                    imageUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
                    message: 'Thanks for your help earlier!',
                    time: '03:45 PM',
                  ),
                  MessageTileWidget(
                    name: 'Jenny Wilson',
                    imageUrl: 'https://randomuser.me/api/portraits/women/5.jpg',
                    message: 'Can you review the document?',
                    time: '04:00 PM',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
