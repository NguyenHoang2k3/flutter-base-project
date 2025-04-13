import 'package:injectable/injectable.dart';

import '../repositories/notification_repository.dart';
import 'use_case.dart';

@injectable
class ChangeFollowNotificationUserUseCase extends UseCase<void, ChangeFollowNotificationUserParam> {
  ChangeFollowNotificationUserUseCase(this._NotificationRepository);
  NotificationRepository _NotificationRepository;

  @override
  Future<bool> call({required ChangeFollowNotificationUserParam params}) async {
    return _NotificationRepository.changeFollowNotificationUser(params.userId);
  }
}

class ChangeFollowNotificationUserParam {
  ChangeFollowNotificationUserParam(
      this.userId,
      );
  final String userId;
}