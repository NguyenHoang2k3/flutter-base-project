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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.pop();
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
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        context.router.push(const ProfileRoute());
                      },
                      child: _comment('assets/images/wilson.png', 'Wilson Franci',
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          '4w', '125 likes', context),
                    ),

                    // reply
                    Padding(
                      padding: const EdgeInsets.only(left: 48.0),
                      child: _comment('assets/images/wilson.png', 'Wilson Franci',
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                          '4w', '125 likes', context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 56.0, bottom: 8),
                      child: Text("See more (2)", style: TextStyle(color: Colors.blue)),
                    ),

                    _comment('assets/images/wilson.png', 'Wilson Franci',
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        '4w', '125 likes', context),
                    Padding(
                      padding: const EdgeInsets.only(left: 56.0, bottom: 8),
                      child: Text("See more (2)", style: TextStyle(color: Colors.blue)),
                    ),

                    _comment('assets/images/wilson.png', 'Wilson Franci',
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        '4w', '125 likes', context),
                    Padding(
                      padding: const EdgeInsets.only(left: 56.0, bottom: 8),
                      child: Text("See more (58)", style: TextStyle(color: Colors.blue)),
                    ),

                    _comment('assets/images/wilson.png', 'Wilson Franci',
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        '4w', '125 likes', context),
                  ],
                ),
              ),

              // Comment input
              Divider(height: 1),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type your comment',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _comment(String avatar, String name, String comment, String time, String like, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(avatar, width: 40, height: 40),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).own()?.textTheme?.h3),
                SizedBox(height: 4),
                Text(comment),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(width: 12),
                    Icon(Icons.favorite_border, size: 14, color: Colors.pink),
                    SizedBox(width: 4),
                    Text(like, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(width: 12),
                    Text('reply', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

