import 'package:flutter_clean_architecture/domain/entities/notification.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/notification_repository.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  NotificationRepositoryImpl();

  @override
  Future<bool> changeFollowNotificationUser(String actorId) {
    // TODO: implement changeFollowNotificationUser
    throw UnimplementedError();
  }

  @override
  Future<List<Notification>> getAllNotification() {
    // TODO: implement getAllNotification
    throw UnimplementedError();
  }
}