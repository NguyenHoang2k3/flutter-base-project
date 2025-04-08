import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/router/router.dart';
import 'package:flutter_svg/svg.dart';
import '../../../base/base_page.dart';
import '../../../resources/colors.dart';
import 'home_bloc.dart';

@RoutePage()
class HomePage extends BasePage<HomeBloc, HomeEvent, HomeState> {
  const HomePage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<HomeBloc>().add(const HomeEvent.loadData());
    super.onInitState(context);
  }

  Widget categoryTab(String title, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              // fontStyle: Regular,
              fontSize: 16,
              color: isSelected ? Colors.black : Colors.grey.shade600,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected) Container(height: 3, width: 34, color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildItem(
    String category,
    String title,
    String source,
    String time,
    String imageUrl,
    String srcImage,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 6),

          // News Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: Color(int.parse('FF4E4B66', radix: 16)),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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
                    Text(
                      source,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.more_horiz, color: Colors.grey.shade400),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              context.router.push(const HomeRoute());
              break;
            case 1:
              break;
            case 2:
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: categories.length,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: SizedBox(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Image.asset('assets/images/Vector.png'),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 99,
                        height: 33,
                      ),
                  InkWell(
                    onTap: () {
                      context.router.push(const NotificationRoute());
                    },
                    borderRadius: BorderRadius.circular(6), // Hiệu ứng ripple bo tròn
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
                        child: SvgPicture.asset(
                          'assets/images/IconNotification.svg',
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    onTap: () {
                      context.router.push(const SearchRoute());
                    },
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.tune, color: Colors.grey),
                        onPressed: () {context.router.push(const SearchRoute());},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: SizedBox(
                  height: 24,
                  child: Row(
                    children: [
                      Text(
                        'Trending',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'See all',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: AppColors.grayScale,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                child: InkWell(
                  onTap: () {
                    context.router.push(const DetailNewsRoute());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/landscape.png'),
                      SizedBox(height: 8),
                      const Text(
                        'Europe',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.grayScale,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 4),
                      const Text(
                        'Russian warship: Moskva sinks in Black Sea',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/bbc.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'BBC News',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              color: AppColors.grayScale,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            '4h ago',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: AppColors.grayScale,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: SizedBox(
                  height: 24,
                  child: Row(
                    children: [
                      Text(
                        'Latest',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'See all',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: AppColors.grayScale,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: SizedBox(
                  height: 34,
                  child: TabBar(
                    labelColor: AppColors.black,
                    unselectedLabelColor: AppColors.grayScale,
                    labelStyle: TextStyle( //khi duoc chon
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'
                    ),
                    unselectedLabelStyle: TextStyle( //khi chua duoc chon
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                    isScrollable: true,
                    tabs: categories.map((category) => Tab(text: category)).toList(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: TabBarView(
                    children: categories.map((category) {
                      return BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          final newsList = state.newsList
                              .where((news) => category == 'All' || news.category == category)
                              .toList();
          
                          if (newsList.isEmpty) {
                            return const Center(child: Text('No news available'));
                          } else {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              itemCount: newsList.length,
                              itemBuilder: (context, index) {
                                final news = newsList[index];
                                return Column(
                                  children: [
                                    _buildItem(
                                      news.category,
                                      news.title,
                                      news.source,
                                      news.time,
                                      news.imageUrl,
                                      news.srcImage,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      );
                    }).toList(),
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

final List<String> categories = [
  'All',
  'Sports',
  'Politics',
  'Business',
  'Health',
  'Travel',
  'Science',
  'Fashion',
  'Europe'
];
