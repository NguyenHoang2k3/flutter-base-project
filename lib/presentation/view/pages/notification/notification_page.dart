import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/shared/extension/context.dart';
import 'package:flutter_clean_architecture/shared/extension/datetime.dart';
import 'package:gap/gap.dart';

import '../../../../domain/entities/notification.dart' as entity;
import '../../../../gen/assets.gen.dart';
import '../../../base/base_page.dart';
import 'notification_bloc.dart';

@RoutePage()
class NotificationPage
    extends BasePage<NotificationBloc, NotificationEvent, NotificationState> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<NotificationBloc>().add(const NotificationEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;
    final iconColor =Theme.of(context).iconTheme.color;
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            shadowColor: Colors.transparent,
            leading: IconButton(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.zero,
              onPressed: context.pop,
              icon: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Assets.icons.backIcon.svg(color: iconColor),
              ),
            ),
            title: Text(
              'Notification',
              style: textTheme?.textMediumLink?.copyWith(
                color: colorSchema?.darkBlack,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: PopupMenuButton<String>(
                  icon: Assets.icons.threedotVertical.svg(color: iconColor),
                  onSelected: (value) {
                    print("Selected: $value");
                  },
                  itemBuilder:
                      (context) => [
                    PopupMenuItem(value: "Settings", child: Text("Settings")),
                    PopupMenuItem(value: "Logout", child: Text("Logout")),
                  ],
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.listNotificatioFollowDay?.length,
                  itemBuilder: (context, index) {
                    final entry = state.listNotificatioFollowDay?.entries
                        .elementAt(index);
                    final List<entity.Notification> subList = entry?.value ?? [];
                    return Padding(
                      padding: const EdgeInsets.only(right: 24, left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subList[0].notifyDay(),
                            style: textTheme?.textMediumLink?.copyWith(
                              color: colorSchema?.darkBlack,
                            ),
                          ),
                          const Gap(16),
                          Column(
                            children:
                            subList.map((notification) {
                              return Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness == Brightness.light ? colorSchema
                                          ?.grayscaleSecondaryButton : colorSchema?.darkmodeInputBackground,
                                      borderRadius: BorderRadius.circular(
                                        6,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                        horizontal: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            height: 70,
                                            child: ClipOval(
                                              child: Image.asset(
                                                notification.imagePath,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Gap(16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text.rich(
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        notification
                                                            .users
                                                            .username,
                                                        style: textTheme
                                                            ?.textMediumLink
                                                            ?.copyWith(
                                                          color:
                                                          colorSchema
                                                              ?.grayscaleTitleactive,
                                                        ),
                                                      ),
                                                      const TextSpan(
                                                        text: ' ',
                                                      ),
                                                      TextSpan(
                                                        text:
                                                        notification
                                                            .message,
                                                        style: textTheme
                                                            ?.textMedium
                                                            ?.copyWith(
                                                          color:
                                                          colorSchema
                                                              ?.grayscaleTitleactive,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  notification.timeNotify.getDayAgo(),
                                                  style: textTheme
                                                      ?.textXSmall
                                                      ?.copyWith(
                                                    color:
                                                    colorSchema
                                                        ?.grayscaleBodyText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          if (notification.typeNotification == "follow") Padding(
                                            padding: const EdgeInsets.only(left: 16),
                                            child: InkWell(
                                              onTap: () {
                                                context
                                                    .read<
                                                    NotificationBloc
                                                >()
                                                    .add(
                                                  NotificationEvent.changeFollowed(
                                                    notification
                                                        .users
                                                        .id ?? '',
                                                  ),
                                                );
                                              },
                                              child:
                                              notification.users.isFollow
                                                  ? Assets.icons.following.svg() : Assets.icons.followIcon.svg(),
                                            ),
                                          ) else const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
