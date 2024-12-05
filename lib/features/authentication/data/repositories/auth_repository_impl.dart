import 'package:convo_sphere/features/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:convo_sphere/features/authentication/domain/entities/user_entity.dart';
import 'package:convo_sphere/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.dataSource});

  final AuthRemoteDataSource dataSource;

  @override
  Future<UserEntity?> login(String email, String password) async {
    return await dataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity?> register(
    String username,
    String email,
    String password,
  ) async {
    return await dataSource.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
