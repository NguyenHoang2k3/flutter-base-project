import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getAllNotification();
  Future<bool> changeFollowNotificationUser(String actorId);
}