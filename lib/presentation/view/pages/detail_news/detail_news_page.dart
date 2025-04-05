import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';

import '../../../base/base_page.dart';
import '../../../resources/colors.dart';
import '../../../router/router.dart';
import 'detail_news_bloc.dart';

@RoutePage()
class DetailNewsPage
    extends BasePage<DetailNewsBloc, DetailNewsEvent, DetailNewsState> {
  const DetailNewsPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<DetailNewsBloc>().add(const DetailNewsEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {


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
                    InkWell(onTap: () {
                      context.router.push(const CommentRoute());
                    },child: Icon(Icons.chat_bubble_outline)),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
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
                SizedBox(height: 16),
                Row(
                  children: [
                    Image.asset('assets/images/bbc.png', width: 50, height: 50),
                    SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BBC News',
                          style:
                              Theme.of(context).own()?.textTheme?.h3,
                        ),
                        Text(
                          '14m ago',
                          style: Theme.of(context).own()?.textTheme?.h2,
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
                          foregroundColor: AppColors.blueee,
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
                              Icon(Icons.add, color: AppColors.blueee),
                              Text(
                                "Follow",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: AppColors.blueee,
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
                      'assets/images/landscape.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Europe',style: Theme.of(context).own()?.textTheme?.h2,),
                    SizedBox(height: 4),
                    Text(
                      'Ukraine\'\s President Zelensky to BBC: Blood money being paid for Russian oil',
                      style: Theme.of(context).own()?.textTheme?.highlightsBold,
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Wrap(
                  children: [
                    Text(
                      '''Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of "earning their money in other people's blood".
                
In an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn (\$\326bn) this year.
                ''', style: Theme.of(context).own()?.textTheme?.small,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
