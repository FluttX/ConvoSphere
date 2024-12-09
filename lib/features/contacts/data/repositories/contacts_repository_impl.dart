import 'package:convo_sphere/features/contacts/data/datasource/remote/contacts_remote_data_source.dart';
import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';
import 'package:convo_sphere/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl({required this.remoteDataSource});

  final ContactsRemoteDataSource remoteDataSource;

  @override
  Future<String> addContact(String contactId) async {
    return await remoteDataSource.addContact(contactId);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() async {
    return await remoteDataSource.fetchContacts();
  }
}
