import 'package:convo_sphere/features/authentication/domain/entities/user_entity.dart';
import 'package:convo_sphere/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  RegisterUseCase({required this.repository});

  final AuthRepository repository;

  Future<UserEntity?> call(String username, String email, String password) {
    return repository.register(username, email, password);
  }
}
