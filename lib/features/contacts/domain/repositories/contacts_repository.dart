import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsRepository {
  Future<List<ContactEntity>> fetchContacts();

  Future<String> addContact(String email);

  Future<List<ContactEntity>> fetchRecentContacts();
}
