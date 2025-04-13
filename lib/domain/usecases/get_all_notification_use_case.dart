import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';

import '../entities/notification.dart';
import '../repositories/notification_repository.dart';
import 'use_case.dart';

@injectable
class GetAllNotificationUseCase extends UseCase<void, GetAllNotificationParam> {
  GetAllNotificationUseCase(this._appNotificationRepository);

  final NotificationRepository _appNotificationRepository;
  @override
  Future<LinkedHashMap<String, List<Notification>>> call({required GetAllNotificationParam params}) async {
    final List<Notification> listNotifications =  await _appNotificationRepository.getAllNotification();
    listNotifications.sort((a, b) => b.timeNotify.compareTo(a.timeNotify));
    final LinkedHashMap<String, List<Notification>> groupedNotifications =
    LinkedHashMap();
    for (final notification in listNotifications) {
      final String formattedDate = DateFormat(
        'yyyy-MM-dd',
      ).format(notification.timeNotify);
      if (!groupedNotifications.containsKey(formattedDate)) {
        groupedNotifications[formattedDate] = [];
      }
      groupedNotifications[formattedDate]!.add(notification);
    }

    return groupedNotifications;
  }
}

class GetAllNotificationParam {
  GetAllNotificationParam();
}