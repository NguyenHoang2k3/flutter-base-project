import 'package:injectable/injectable.dart';
import '../../domain/entities/notification.dart';
import '../../domain/entities/users.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../shared/common/error_entity/business_error_entity.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  NotificationRepositoryImpl();

  @override
  Future<List<Notification>> getAllNotification() async {
    try {
      return _notifications;
    } catch (e) {
      throw BusinessErrorEntityData(
        name: 'Notification dont loading',
        message: 'Notification dont loading',
      );
    }
  }

  @override
  Future<bool> changeFollowNotificationUser(String userId) async {
    try {
      final Notification appNotification = _notifications.firstWhere(
        (notification) => notification.users.id == userId,
      );
      appNotification.users.isFollow = !appNotification.users.isFollow;
      return true;
    } catch (e) {
      throw BusinessErrorEntityData(
        name: 'Change followers error',
        message: 'Change followers error',
      );
    }
  }

  static List<Notification> _notifications = [
    Notification(
      '2',
      "assets/images/cnn.png",
      Users("15", 'CNN', '', '', '', 0, true),
      'likes your news "Minting Your First NFT: A\'s Guide"',
      DateTime(2025, 4, 13, 12, 35),
      "like",
    ),
    Notification(
      "3",
      "assets/images/cnet.png",
      Users("15", 'CNET', '', '', '', 0, true),
      "is now following you",
      DateTime(2025, 3, 20, 23, 50),
      "follow", // Corrected hour
    ),
    Notification(
      "4",
      "assets/images/cnbc.png",
      Users("15", 'CNBC', '', '', '', 0, true),
      'has share your news "Minting Your First NFT: A\'s Guide"',
      DateTime(2025, 3, 26, 9, 20),
      "share",
    ),
    Notification(
      "5",
      "assets/images/cnn.png",
      Users("15", 'CNN', '', '', '', 0, true),
      'likes your news "Ukraine President Zelensky to BBC: Blood money being paid for Ruissian oil"',
      DateTime(2025, 3, 26, 12, 35),
      "like",
    ),
    Notification(
      "7",
      "assets/images/bbc.png",
      Users("15", 'BBC', '', '', '', 0, true),
      "is now following you",
      DateTime(2025, 3, 25, 7, 55),
      "follow",
    ),
    Notification(
      "8",
      "assets/images/cnn.png",
      Users("15", 'CNN', '', '', '', 0, true),
      'has share your news "Minting Your First NFT: A\'s Guide"',
      DateTime(2025, 3, 25, 10, 15),
      "like",
    ),
    Notification(
      "9",
      "assets/images/cnn.png",
      Users("15", 'CNN', '', '', '', 0, true),
      "is now following you",
      DateTime(2025, 3, 24, 12, 30),
      "follow",
    ),
    Notification(
      "10",
      "assets/images/cnet.png",
      Users("15", 'CNET', '', '', '', 0, true),
      'has share your news "Minting Your First NFT: A\'s Guide"',
      DateTime(2025, 3, 24, 15, 20),
      "share",
    ),
    Notification(
      "11",
      "assets/images/bbc.png",
      Users("15", 'BBC', '', '', '', 0, true),
      "has send a message for you",
      DateTime(2025, 3, 24, 18, 10),
      "message",
    ),
  ];
}
