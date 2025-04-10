import 'package:injectable/injectable.dart';

import 'use_case.dart';

@injectable
class GetSearchTopicsUseCase extends UseCase<void, GetSearchTopicsParam> {
  GetSearchTopicsUseCase();

  @override
  Future<bool> call({required GetSearchTopicsParam params}) async {
    // TODO
    return false;
  }
}

class GetSearchTopicsParam {
  GetSearchTopicsParam();
}