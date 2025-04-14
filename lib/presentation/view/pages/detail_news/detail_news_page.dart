import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/shared/extension/context.dart';
import 'package:flutter_svg/svg.dart';

import '../../../base/base_page.dart';
import '../../../base/page_status.dart';
import '../../../resources/colors.dart';
import '../../../router/router.dart';
import 'detail_news_bloc.dart';

@RoutePage()
class DetailNewsPage
    extends BasePage<DetailNewsBloc, DetailNewsEvent, DetailNewsState> {
  final String newsId;
  const DetailNewsPage(this.newsId, {Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<DetailNewsBloc>().add(DetailNewsEvent.loadDataDetail(newsId));
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;

    return BlocBuilder<DetailNewsBloc, DetailNewsState>(
  builder: (context, state) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 78,
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.pink),
                    SizedBox(width: 4),
                    Text("24.5K", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 16),
                    InkWell(
                      onTap: () {
                        context.router.push( CommentRoute(newsId: state.newsDetail?.id ??''));
                      },
                      child: SvgPicture.asset('assets/images/comment.svg'),
                    ),
                    SizedBox(width: 4),
                    Text("1K", style: TextStyle(fontSize: 14)),
                  ],
                ),
                Icon(Icons.bookmark, color: Colors.blue),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
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
                  Spacer(),
                  Image.asset('assets/images/3chau.png', width: 24, height: 24),
                  SizedBox(width: 8),
                  Image.asset('assets/images/dotY.png', width: 24, height: 24),
                ],
              ),
            ),

            SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<DetailNewsBloc, DetailNewsState>(
                builder: (context, state) {
                  if (state.pageStatus != PageStatus.Loaded) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.pageStatus == PageStatus.Loaded &&
                      state.newsDetail != null) {
                    final news = state.newsDetail!;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Image.asset(news.srcImage ?? '',
                                    width: 50, height: 50),
                                SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      news.source ?? '',
                                      style: textTheme?.textMediumLink?.copyWith(
                                        color: colorSchema?.darkBlack,
                                      ),
                                    ),
                                    Text(
                                      '14m ago',
                                      style: textTheme?.textSmall?.copyWith(
                                        color: colorSchema?.grayscaleBodyText,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 102,
                                  height: 34,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      fixedSize: Size(78, 34),
                                      foregroundColor: AppColors.blueRibbon,
                                      side:
                                      BorderSide(color: AppColors.blueRibbon),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,
                                              color: AppColors.blueRibbon),
                                          Text(
                                            "Follow",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              color: AppColors.blueRibbon,
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
                            SizedBox(height: 16),
                            SizedBox(
                              height: 248,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  news.imageUrl ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.category ?? '',
                                  style: textTheme?.textSmall?.copyWith(
                                    color: colorSchema?.grayscaleBodyText,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  news.title ?? '',
                                  style: textTheme?.textDisplaySmall?.copyWith(
                                    color: colorSchema?.darkBlack,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Wrap(
                              children: [
                                Text(
                                  news.context ?? '',
                                  style: textTheme?.textMedium?.copyWith(
                                    color: colorSchema?.grayscaleBodyText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text("No data available"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
