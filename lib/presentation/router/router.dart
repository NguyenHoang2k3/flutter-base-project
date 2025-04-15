import 'package:auto_route/auto_route.dart';

import '../view/pages/detail_news/detail_news_page.dart';
import '../view/pages/settings/settings_page.dart';

import '../view/pages/edit_profile/edit_profile_page.dart';

import '../view/pages/profile/profile_page.dart';

import '../view/pages/comment/comment_page.dart';


import '../view/pages/notification/notification_page.dart';

import '../view/pages/search/search_page.dart';

import '../view/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/task.dart';
import '../view/pages/home/home_page.dart';
import '../view/pages/new_task/new_task_page.dart';
import '../view/pages/task_detail/task_detail_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Dialog|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: NewTaskRoute.page),
    AutoRoute(page: TaskDetailRoute.page),
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: SearchRoute.page),
    AutoRoute(page: NotificationRoute.page),
    AutoRoute(page: DetailNewsRoute.page),
    AutoRoute(page: CommentRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: EditProfileRoute.page),
    AutoRoute(page: SettingsRoute.page),
  ];

  @override
  List<NavigatorObserver> navigatorObservers() => [AutoRouteObserver()];
}
