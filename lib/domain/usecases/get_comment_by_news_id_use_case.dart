
import 'package:flutter_clean_architecture/domain/repositories/news_comment_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/news_comment.dart';
import 'use_case.dart';

@injectable
class GetCommentByNewsIdUseCase extends UseCase<void, GetCommentByNewsIdParam> {
  GetCommentByNewsIdUseCase(this._newsCommentRepository);
  NewsCommentRepository _newsCommentRepository;

  @override
  Future<List<NewsComment>> call({required GetCommentByNewsIdParam params}) async {
    List<NewsComment> listComments = await _newsCommentRepository.getCommentByNewsId(params.newsId);
    listComments.sort((a, b) => a.createAt.compareTo(b.createAt));
    return listComments;
  }
}

class GetCommentByNewsIdParam {
  GetCommentByNewsIdParam(this.newsId);
  final String newsId;
}