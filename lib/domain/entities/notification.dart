import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  String notificationId;
  String imagePath;
  String message;
  DateTime timeNotify;
  String typeNotification;

  Notification(
      this.notificationId,
      this.imagePath,
      this.message,
      this.timeNotify,
      this.typeNotification,
      );

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  String _getMonthName() {
    return DateFormat.MMMM("en").format(timeNotify);
  }

  String notifyDay() {
    final duration = DateTime.now().difference(timeNotify);
    final durationForYear = DateTime.now();
    if (duration.inDays == 0) {
      return 'Today, ${_getMonthName()} ${timeNotify.day}';
    }
    if (duration.inDays == 1) {
      return 'Yesterday, ${_getMonthName()} ${timeNotify.day}';
    }
    if (durationForYear.year == timeNotify.year) {
      return '${_getMonthName()} ${timeNotify.day}';
    } else {
      return '${_getMonthName()} ${timeNotify.day} ${timeNotify.year}';
    }
  }
}