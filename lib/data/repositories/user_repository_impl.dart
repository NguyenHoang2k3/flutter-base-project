
import 'package:flutter_clean_architecture/data/translator/users_translator.dart';
import 'package:flutter_clean_architecture/domain/entities/users.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/user_repository.dart';
import '../remote/datasources/news_remote_data_source.dart';

@Injectable(as: UsersRepository)
class UsersRepositoryImpl extends UsersRepository {
  UsersRepositoryImpl(this._newsRemoteDataSource);
  final NewsRemoteDataSource _newsRemoteDataSource;
  @override
  Future<List<Users>> getUsers() async {
    final response = await _newsRemoteDataSource.getUsers();

    return response.map((e) => e.toEntity()).toList();
  }

}