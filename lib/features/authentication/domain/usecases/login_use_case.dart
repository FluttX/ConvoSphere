import 'package:convo_sphere/features/authentication/domain/entities/user_entity.dart';
import 'package:convo_sphere/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase({required this.repository});

  final AuthRepository repository;

  Future<UserEntity?> call(String email, String password) {
    return repository.login(email, password);
  }
}
