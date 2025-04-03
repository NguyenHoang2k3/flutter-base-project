import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/resources/colors.dart';
import '../../../base/base_page.dart';
import '../../../router/router.dart';
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.router.push(const HomeRoute());
                        },

                        child: Image.asset(
                          'assets/images/back.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Image.asset(
                        'assets/images/dotY.png',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Today, April 22',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8,),
                buildNotification(
                    'assets/images/bbc.png',
                    'BBC News',
                    'has posted new europe news "Ukraines President Zele"',
                    '15m ago'
                ),
                buildNotification(
                    'assets/images/bbc.png',
                    'BBC News',
                    'has posted new europe news "Ukraines President Zele"',
                    '15m ago'
                ),
                buildNotification(
                    'assets/images/bbc.png',
                    'BBC News',
                    'has posted new europe news "Ukraines President Zele"',
                    '15m ago'
                ),
                const SizedBox(height: 16),
                const Text(
                  'Today, April 22',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8,),
                buildNotification(
                    'assets/images/bbc.png',
                    'BBC News',
                    'has posted new europe news "Ukraines President Zele"',
                    '15m ago'
                ),
                buildNotification(
                    'assets/images/bbc.png',
                    'BBC News',
                    'has posted new europe news "Ukraines President Zele"',
                    '15m ago'
                ),
                buildNotification(
                    'assets/images/bbc.png',
                    'BBC News',
                    'has posted new europe news "Ukraines President Zele"',
                    '15m ago'
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNotification(String categoryImage, String category, String context, String time) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: SizedBox(
        height: 99,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.grayScaleButton,
            borderRadius: BorderRadius.circular(10), // Bo góc
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 8,),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(categoryImage, width: 70, height: 70),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 14, 8, 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: category,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grayScaleTitle,
                              ),
                            ),
                            TextSpan(
                              text: ' $context',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 16, // Fixed font size typo (was 166)
                                color: AppColors.grayScaleTitle,
                              ),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.grayScale,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}