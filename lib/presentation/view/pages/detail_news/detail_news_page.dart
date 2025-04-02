import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_page.dart';
import 'detail_news_bloc.dart';

@RoutePage()
class DetailNewsPage extends BasePage<DetailNewsBloc, DetailNewsEvent, DetailNewsState> {
  const DetailNewsPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<DetailNewsBloc>().add(const DetailNewsEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}