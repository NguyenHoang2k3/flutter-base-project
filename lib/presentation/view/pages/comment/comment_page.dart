import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';

import '../../../base/base_page.dart';
import '../../../router/router.dart';
import 'comment_bloc.dart';

@RoutePage()
class CommentPage extends BasePage<CommentBloc, CommentEvent, CommentState> {
  const CommentPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<CommentBloc>().add(const CommentEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 27),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.push(const DetailNewsRoute());
                    },
                    child: Image.asset(
                      'assets/images/back.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Text('Comments', style: Theme.of(context).own()?.textTheme?.h3),
                  SizedBox(width: 24),
                ],
              ),
          /*    ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [

                    ],
                  );
                },
              )*/

            ],
          ),
        ),
      ),
    );
  }

  Widget _comment(String avatar, String name, String comment,String time,String like,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Image.asset(avatar, width: 40, height: 40),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                child: Column(
                    children: [
                  Text(name, style: Theme.of(context).own()?.textTheme?.h2,),
                      Text(comment, style: Theme.of(context).own()?.textTheme?.h2,),
                      Row(
                        children: [
                        ],
                      )
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
