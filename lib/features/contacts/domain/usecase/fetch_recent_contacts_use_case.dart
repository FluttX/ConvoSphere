import 'package:convo_sphere/features/contacts/domain/entities/contact_entity.dart';
import 'package:convo_sphere/features/contacts/domain/repositories/contacts_repository.dart';

class FetchRecentContactsUseCase {
  FetchRecentContactsUseCase({required ContactsRepository repository})
      : _repository = repository;

  final ContactsRepository _repository;

  Future<List<ContactEntity>> call() async {
    return await _repository.fetchRecentContacts();
  }
}
