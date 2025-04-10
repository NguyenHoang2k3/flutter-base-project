import 'package:injectable/injectable.dart';
import '../../domain/repositories/author_repository_repository.dart';

@Injectable(as: AuthorRepositoryRepository)
class AuthorRepositoryRepositoryImpl extends AuthorRepositoryRepository {
  AuthorRepositoryRepositoryImpl();
}