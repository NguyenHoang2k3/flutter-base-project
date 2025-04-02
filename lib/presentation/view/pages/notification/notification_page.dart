import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_page.dart';
import 'notification_bloc.dart';

@RoutePage()
class NotificationPage extends BasePage<NotificationBloc, NotificationEvent, NotificationState> {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<NotificationBloc>().add(const NotificationEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {},
      ),
      body: SafeArea(
          child: Row(
            children: [
            Text('Notification')
            ],
          )
      ),

    );
  }
}