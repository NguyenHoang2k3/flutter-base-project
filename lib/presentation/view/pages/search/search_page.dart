import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/resources/colors.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';
import '../../../base/base_page.dart';
import '../../../base/page_status.dart';
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
                    onChanged: (value) {
                      context.read<SearchBloc>().add(SearchEvent.queryChanged(value));
                    },
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {context.pop();},
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
                  height: 16 / 22,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
                unselectedLabelStyle: const TextStyle(
                  height: 16 / 22,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 0.0,
                ),
                isScrollable: true,
                tabs:
                    categories.map((category) => Tab(text: category)).toList(),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.pageStatus != PageStatus.Loaded) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return TabBarView(
                      children: [
                        // News
                        ListView.builder(
                          itemCount: state.listNews?.length,
                          itemBuilder: (context, index) {
                            final news = state.listNews?[index];
                            return _buildItem(
                              news!.category,
                              news.title,
                              news.source,
                              news.time,
                              news.imageUrl,
                              news.srcImage,
                              context,
                            );
                          },
                        ),

                        // Topics
                        ListView.builder(
                          itemCount: state.listTopics?.length,
                          itemBuilder: (context, index) {
                            final topic = state.listTopics?[index];
                            return _buildItemTopic(
                              topic!.id,
                              topic!.imageUrl,
                              topic.name,
                              topic.context,
                              context,
                            );
                          },
                        ),

                        // Author
                        ListView.builder(
                          itemCount: state.listUsers?.length,
                          itemBuilder: (context, index) {
                            final author = state.listUsers?[index];
                            return _buildItemAuthor(
                              author!.imageUrl,
                              author!.username,
                              '1.2M Followers',
                              context,
                            );
                          },
                        ),
                      ],
                    );
                  },
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
      BuildContext context
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 0),
      child: SizedBox(
        height: 112,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,8,4,8 ),
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

            // News Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: Theme.of(context).own()?.textTheme?.h2,
                    ),
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
                        Text(
                          source,
                          style: Theme.of(context).own()?.textTheme?.primary,
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
                          style: Theme.of(context).own()?.textTheme?.medium,
                        ),
                        const Spacer(),
                        Icon(Icons.more_horiz, color: Colors.grey.shade400),
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

  Widget _buildItemTopic(
      String index,
    String image,
    String title,
    String contextt,
    BuildContext context,
  ) {
    final topic = context.read<SearchBloc>().state.listTopics?.firstWhere((t) => t.id == index);
    final isSaved = topic?.save ?? false;
    return SizedBox(
      height: 86,
      child: Row(
        children: [
          SizedBox(width: 4.5),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 70, height: 70),
          ),
          SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).own()?.textTheme?.h3),
                SizedBox(height: 4),
                SizedBox(
                  width: 190,
                  child: Text(
                    contextt,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).own()?.textTheme?.h2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 78,
            height: 34,
            child: TextButton(
              onPressed: () {
                context.read<SearchBloc>().add(SearchEvent.changeSaveTopic(index));
              },
              style: TextButton.styleFrom(
                backgroundColor: isSaved ? AppColors.blueee : AppColors.white,
                fixedSize: Size(78, 34),
                foregroundColor: AppColors.blueee,
                side: BorderSide(color: AppColors.blueee),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  isSaved ? "Saved" : "Save",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: isSaved ? AppColors.white : AppColors.blueee,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemAuthor(
    String image,
    String title,
    String followers,
    BuildContext context,
  ) {
    final author = context.read<SearchBloc>().state.listUsers?.firstWhere((u) => u.username == title);
    final isFollowed = author?.isFollow ?? false;
    return SizedBox(
      height: 86,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: Image.asset(image, width: 70, height: 70),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4, 18.5, 0, 18.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).own()?.textTheme?.h3),
                SizedBox(height: 4),
                Text(followers, style: Theme.of(context).own()?.textTheme?.h2),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: 95,
            height: 32,
            child: TextButton(
              onPressed: () {
                context.read<SearchBloc>().add(SearchEvent.changeFollowUser(title));
              },
              style: TextButton.styleFrom(
                backgroundColor: isFollowed ? AppColors.blueee : AppColors.white,
                fixedSize: Size(78, 34),
                foregroundColor: isFollowed ? AppColors.white : AppColors.blueee,
                side: BorderSide(color: AppColors.blueee),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isFollowed)
                      Icon(Icons.add, color: AppColors.blueee),
                    Text(
                      isFollowed ? "Following" : "Follow",
                      style: TextStyle(
                        fontSize: isFollowed ? 14 : 16,
                        fontFamily: 'Poppins',
                        color: isFollowed ? AppColors.white : AppColors.blueee,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
