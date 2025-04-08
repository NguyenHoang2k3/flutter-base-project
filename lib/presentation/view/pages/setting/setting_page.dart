import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../base/base_page.dart';
import '../../../router/router.dart';
import 'setting_bloc.dart';

@RoutePage()
class SettingPage extends BasePage<SettingBloc, SettingEvent, SettingState> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<SettingBloc>().add(const SettingEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 24,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Settings',
                      style: Theme.of(context).own()?.textTheme?.h3,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.router.push(const ProfileRoute());
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/images/back.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 3, 4, 3),
                    child: Image.asset('assets/images/noti.png', width: 16, height: 18),
                  ),
                  SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      context.router.push(const NotificationRoute());
                    },
                    child: Text(
                      'Notification',
                      style: Theme.of(context).own()?.textTheme?.h3,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                    child: SvgPicture.asset(
                      'assets/images/next.svg',
                      width: 6,
                      height: 8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 1.5, 3, 1.5),
                    child: SvgPicture.asset(
                      'assets/images/lock.svg',
                      width: 18,
                      height: 21,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Security',
                    style: Theme.of(context).own()?.textTheme?.h3,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                    child: SvgPicture.asset(
                      'assets/images/next.svg',
                      width: 6,
                      height: 8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: SvgPicture.asset(
                      'assets/images/ques.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Help',
                    style: Theme.of(context).own()?.textTheme?.h3,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
                    child: SvgPicture.asset(
                      'assets/images/next.svg',
                      width: 6,
                      height: 8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: SvgPicture.asset(
                      'assets/images/dark.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Dark Mode',
                    style: Theme.of(context).own()?.textTheme?.h3,
                  ),
                  Spacer(),
                  CupertinoSwitch(
                    value: true,
                    onChanged: (value) {
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2.5, 2, 2.5, 2),
                    child: SvgPicture.asset(
                      'assets/images/logout.svg',
                      width: 19,
                      height: 20,
                    ),
                  ),
                  SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      context.router.push(const LoginRoute());
                    },
                    child: Text(
                      'Logout',
                      style: Theme.of(context).own()?.textTheme?.h3,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
