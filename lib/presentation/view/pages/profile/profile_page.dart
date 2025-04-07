import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/resources/colors.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';

import '../../../base/base_page.dart';
import 'profile_bloc.dart';

@RoutePage()
class ProfilePage extends BasePage<ProfileBloc, ProfileEvent, ProfileState> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<ProfileBloc>().add(const ProfileEvent.loadData());
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 24),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/setting.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 13),
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.white,
                      backgroundImage: AssetImage('assets/images/wilson.png'),
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
              ),

              const SizedBox(height: 12),

              // Name & Bio
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Wilson Franci',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 16),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Edit profile"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Website"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Tabs
              Row(
                children: const [
                  Text("News", style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recent", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      SizedBox(
                        width: 40,
                        child: Divider(thickness: 2, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Article List
              Expanded(
                child: ListView(
                  children: [
                    _articleItem('NFTs', 'Minting Your First NFT: A Beginner’s Guide to Creating...', '15m ago'),
                    _articleItem('Business', '5 things to know before the stock market opens Monday', '1h ago'),
                    _articleItem('Travel', 'Bali plans to reopen to international tourists in Septe...', '1w ago'),
                    _articleItem('Health', 'Healthy Living: Diet and Exercise Tips', '2w ago'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

// Profile stat item widget
class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

// Article item widget
Widget _articleItem(String category, String title, String time) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[300],
          ),
          child: Icon(Icons.image, size: 30),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category, style: TextStyle(color: Colors.blue, fontSize: 12)),
              const SizedBox(height: 4),
              Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(
                children: [
                  CircleAvatar(
                    radius: 8,
                    backgroundImage: AssetImage('assets/images/wilson.png'),
                  ),
                  const SizedBox(width: 4),
                  Text("Wilson Franci", style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 8),
                  Icon(Icons.access_time, size: 14),
                  const SizedBox(width: 4),
                  Text(time, style: TextStyle(fontSize: 12)),
                ],
              )
            ],
          ),
        ),
        Icon(Icons.more_horiz),
      ],
    ),
  );
}
