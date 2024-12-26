import 'package:convo_sphere/features/chat/presentation/ui/chat_page.dart';
import 'package:convo_sphere/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:convo_sphere/features/conversation/presentation/widgets/no_conversation_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactsBloc>(context).add(FetchContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: BlocListener<ContactsBloc, ContactsState>(
        listener: (context, state) async {
          final contactBloc = BlocProvider.of<ContactsBloc>(context);

          if (state is ConversationReady) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(
                  name: state.contactName,
                  conversationId: state.conversationId,
                  profileImage: state.contactImage,
                ),
              ),
            );

            if (result == null) {
              contactBloc.add(FetchContactsEvent());
            }
          } else if (state is ConversationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is ContactsLoaded) {
              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact.profileImage),
                    ),
                    title: Text(
                      contact.username,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      contact.email,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      BlocProvider.of<ContactsBloc>(context).add(
                        CheckOrCreateConversationEvent(contact),
                      );
                    },
                  );
                },
              );
            } else if (state is ContactsError) {
              return Center(child: Text(state.message));
            }

            return const NoConversationFound();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Add Contact',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter email address',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final email = controller.text.trim();

              if (email.isNotEmpty) {
                BlocProvider.of<ContactsBloc>(context).add(
                  AddContactsEvent(email),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
