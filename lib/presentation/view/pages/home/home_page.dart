import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/router/router.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';
import '../../../base/base_page.dart';
import '../../../base/page_status.dart';
import '../../../resources/colors.dart';
import 'home_bloc.dart';

@RoutePage()
class HomePage extends BasePage<HomeBloc, HomeEvent, HomeState> {
  const HomePage({super.key});

  @override
  void onInitState(BuildContext context) {
    context.read<HomeBloc>().add(const HomeEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: 0,
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
                BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Explore'),
                BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Bookmark'),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
              ],
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 80),
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: TextField(
                          onTap: () => context.router.push(const SearchRoute()),
                          decoration: InputDecoration(
                            fillColor: AppColors.white,
                            hintText: "Search",
                            hintStyle: TextStyle(color: AppColors.a),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset('assets/images/search.png', width: 20, height: 20),
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset('assets/images/ho.png', width: 20, height: 20),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: AppColors.grayScale),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: _sectionHeader(context, 'Trending'),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          final newsList = state.newsList;
                          if (newsList.isEmpty) return SizedBox.shrink();
                          final news = newsList[0];
                          return GestureDetector(
                            onTap: () => context.router.push(const DetailNewsRoute()),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(news.imageUrl),
                                  const SizedBox(height: 8),
                                  Text(news.source, style: Theme.of(context).own()?.textTheme?.title),
                                  const SizedBox(height: 4),
                                  Text(
                                    news.title,
                                    style: Theme.of(context).own()?.textTheme?.h3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(news.srcImage, width: 20, height: 20),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(news.category, style: Theme.of(context).own()?.textTheme?.primary),
                                      const SizedBox(width: 8),
                                      Icon(Icons.access_time, size: 12, color: Colors.grey.shade500),
                                      const SizedBox(width: 2),
                                      Text(news.time, style: Theme.of(context).own()?.textTheme?.title),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: _sectionHeader(context, 'Latest'),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _TabBarDelegate(
                        TabBar(
                          isScrollable: true,
                          indicatorColor: AppColors.blueee,
                          indicatorWeight: 2.0,
                            indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: EdgeInsets.only(bottom: 6),
                          tabs: categories.map((e) => Tab(text: e)).toList(),
                          labelPadding: EdgeInsets.symmetric(horizontal: 5),
                          labelColor: AppColors.black,
                          unselectedLabelColor: AppColors.grayScale,
                          labelStyle: Theme.of(context).own()?.textTheme?.h3,
                          unselectedLabelStyle: Theme.of(context).own()?.textTheme?.small,
                        ),
                      ),
                    ),
                  ],
                  body: TabBarView(
                    children: categories.map((category) {
                      return BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state.pageStatus != PageStatus.Loaded) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          final list = state.newsList.where((news) => category == 'All' || news.category == category).toList();
                          if (list.isEmpty) return Center(child: Text('No news available'));
                          return ListView.separated(
                            padding: const EdgeInsets.all(24),
                            itemCount: list.length,
                            separatorBuilder: (_, __) => SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final news = list[index];
                              return _buildItem(news, context);
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),

          // Fixed Header with logo and notification icon
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/logo.png', width: 99, height: 33),
                  InkWell(
                    onTap: () => context.router.push(const NotificationRoute()),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/notii.png',
                          width: 18,
                          height: 21.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Text(title, style: Theme.of(context).own()?.textTheme?.highlightsMedium),
          const Spacer(),
          Text('See all', style: Theme.of(context).own()?.textTheme?.h2),
        ],
      ),
    );
  }

  Widget _buildItem(news, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(news.imageUrl, width: 96, height: 96, fit: BoxFit.cover),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.category, style: Theme.of(context).own()?.textTheme?.h2),
              const SizedBox(height: 4),
              Text(news.title, style: Theme.of(context).own()?.textTheme?.h3, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(news.srcImage, width: 20, height: 20, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 4),
                  Text(news.source, style: Theme.of(context).own()?.textTheme?.primary),
                  const SizedBox(width: 8),
                  Icon(Icons.access_time, size: 12, color: Colors.grey.shade500),
                  const SizedBox(width: 2),
                  Text(news.time, style: Theme.of(context).own()?.textTheme?.title),
                  const Spacer(),
                  Icon(Icons.more_horiz, color: Colors.grey.shade400),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;
  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}

final List<String> categories = [
  'All', 'Sports', 'Politics', 'Business', 'Health', 'Travel', 'Science', 'Fashion', 'Europe',
];
