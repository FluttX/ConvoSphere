import 'package:convo_sphere/features/contacts/data/datasource/remote/contacts_remote_data_source.dart';
import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';
import 'package:convo_sphere/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl({required ContactsRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final ContactsRemoteDataSource _remoteDataSource;

  @override
  Future<String> addContact(String contactId) {
    return _remoteDataSource.addContact(contactId);
  }

  @override
  Future<List<ContactEntity>> fetchContacts() {
    return _remoteDataSource.fetchContacts();
  }

  @override
  Future<List<ContactEntity>> fetchRecentContacts() {
    return _remoteDataSource.fetchRecentContacts();
  }
}
