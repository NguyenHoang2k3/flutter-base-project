import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/domain/entities/current_user.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../resources/colors.dart';
import '../../../router/router.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<CurrentUser?> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      return CurrentUser.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              context.router.push(const HomeRoute());
              break;
            case 3:
              context.router.push(const ProfileRoute());
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined), label: 'Bookmark'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      body: SafeArea(
        child: FutureBuilder<CurrentUser?>(
          future: _loadUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load profile'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No user logged in'));
            }

            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 24,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Profile',
                            style: Theme.of(context).own()?.textTheme?.h3,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.router.push(const SettingRoute());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'assets/images/setting.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.white,
                        backgroundImage: user.imagePath != null
                            ? AssetImage(user.imagePath!)
                            : null,
                        child: user.imagePath == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            _ProfileStat(value: '2156', label: 'Followers'),
                            _ProfileStat(value: '567', label: 'Following'),
                            _ProfileStat(value: '23', label: 'News'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user.fullName ?? '',
                      style:
                      Theme.of(context).own()?.textTheme?.highlightsMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user.bio ?? '',
                      style: Theme.of(context).own()?.textTheme?.small,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              context.router.push(const EditProfileRoute());
                            },
                            child: const Text("Edit profile"),
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              backgroundColor: AppColors.blueee,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Website"),
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              backgroundColor: AppColors.blueee,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 36,
                            child: Align(
                              alignment: Alignment.center,
                              child: TabBar(
                                indicatorColor: AppColors.blueee,
                                labelColor: Colors.black,
                                unselectedLabelColor: AppColors.grayScale,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  height: 24 / 16,
                                ),
                                unselectedLabelStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  height: 24 / 16,
                                ),
                                indicatorSize: TabBarIndicatorSize.label,
                                tabAlignment: TabAlignment.center,
                                labelPadding:
                                EdgeInsets.fromLTRB(12, 0, 12, 0),
                                dividerColor: Colors.transparent,
                                indicator: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.blueee, width: 4),
                                  ),
                                ),
                                tabs: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Tab(text: 'News'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Tab(text: 'Recent'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: TabBarView(
                              children: [
                                _buildNewsList(),
                                _buildNewsList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).own()?.textTheme?.highlightsMedium,
        ),
        Text(label, style: Theme.of(context).own()?.textTheme?.small),
      ],
    );
  }
}

Widget _buildNewsList() {
  final List<Map<String, String>> newsList = [
    {
      "category": "Europe",
      "title":
      "Ukraine President Zelensky to BBC: Blood money being paid thens jejee",
      "source": "BBC News",
      "time": "14m ago",
      "imageUrl": "assets/images/ImageNews.png",
      "srcImage": "assets/images/cnn.png",
    },
    {
      "category": "Europe",
      "title":
      "Ukraine President Zelensky to BBC: Blood money being paid thens jejee",
      "source": "BBC News",
      "time": "14m ago",
      "imageUrl": "assets/images/ImageNews.png",
      "srcImage": "assets/images/cnn.png",
    },
  ];

  return ListView.builder(
    padding: const EdgeInsets.symmetric(vertical: 8),
    itemCount: newsList.length,
    itemBuilder: (context, index) {
      final news = newsList[index];
      return _buildItem(
        news['category']!,
        news['title']!,
        news['source']!,
        news['time']!,
        news['imageUrl']!,
        news['srcImage']!,
        context,
      );
    },
  );
}

Widget _buildItem(String category, String title, String source, String time,
    String imageUrl, String srcImage, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    child: SizedBox(
      height: 112,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category,
                      style: Theme.of(context).own()?.textTheme?.h2),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: Theme.of(context).own()?.textTheme?.h3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          srcImage,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(source,
                          style: Theme.of(context)
                              .own()
                              ?.textTheme
                              ?.primary),
                      const SizedBox(width: 8),
                      Icon(Icons.access_time,
                          size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 2),
                      Text(time,
                          style:
                          Theme.of(context).own()?.textTheme?.medium),
                      const Spacer(),
                      Icon(Icons.more_horiz,
                          color: Colors.grey.shade400),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
