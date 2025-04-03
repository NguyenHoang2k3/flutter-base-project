import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/resources/colors.dart';
import '../../../base/base_page.dart';
import 'search_bloc.dart';

@RoutePage()
class SearchPage extends BasePage<SearchBloc, SearchEvent, SearchState> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<SearchBloc>().add(const SearchEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    final List<String> categories = ['News', 'Topics', 'Author'];

    return DefaultTabController(
      length: categories.length,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 47),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TabBar(
                indicatorWeight: 4.0,
                labelColor: AppColors.black,
                unselectedLabelColor: AppColors.grayScale,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                indicatorPadding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                isScrollable: true,
                tabs: categories.map((category) => Tab(text: category)).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildNewsList(),
                  ],
                ),
              ),
            ],
          ),
        ),
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
  Widget _buildNewsList() {
    final List<Map<String, String>> newsList = [
      {
        "category": "Europe",
        "title": "Ukraine President Zelensky to BBC: Blood money being paid thens jejee",
        "source": "BBC News",
        "time": "14m ago",
        "imageUrl": "assets/images/ImageNews.png",
        "srcImage": "assets/images/cnn.png",
      },
      {
        "category": "Europe",
        "title": "Ukraine President Zelensky to BBC: Blood money being paid thens jejee",
        "source": "BBC News",
        "time": "14m ago",
        "imageUrl": "assets/images/ImageNews.png",
        "srcImage": "assets/images/cnn.png",
      },
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
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
        );
      },
    );
  }

}
