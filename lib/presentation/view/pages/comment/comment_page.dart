import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/view/pages/comment/component/comment.dart';
import 'package:flutter_clean_architecture/presentation/view/widgets/app_form_field.dart';
import 'package:flutter_clean_architecture/shared/extension/context.dart';
import 'package:gap/gap.dart';
import '../../../../gen/assets.gen.dart';
import '../../../base/base_page.dart';
import '../../../router/router.dart';
import 'comment_bloc.dart';

@RoutePage()
class CommentPage extends BasePage<CommentBloc, CommentEvent, CommentState> {
  const CommentPage({Key? key, required this.newsId}) : super(key: key);
  final String newsId;

  @override
  void onInitState(BuildContext context) {
    final newsId = context.routeData.argsAs<CommentRouteArgs>().newsId;
    context.read<CommentBloc>().add(CommentEvent.loadData(newsId));
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;
    final iconColor =Theme.of(context).iconTheme.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light, // iOS
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: context.pop,
              icon: Assets.icons.backIcon.svg(color: iconColor),
            ),
            title: Text(
              "Comment",
              style: textTheme?.textMedium?.copyWith(
                color: colorSchema?.darkBlack,
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  reverse: true,
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: BlocBuilder<CommentBloc, CommentState>(
                                buildWhen: (preState, state) {
                                  return preState.listComments != state.listComments;
                                },
                                builder: (context, state) {
                                  return ListViewComment(
                                    listComments: state.listComments ?? [],
                                  );
                                },
                              ),
                            ),
                          ),
                          BlocBuilder<CommentBloc, CommentState>(
                            buildWhen: (preState, state) {
                              return preState.commentInput != state.commentInput ||
                                  preState.enableSendComment != state.enableSendComment;
                            },
                            builder: (context, state) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                height: 78,
                                decoration: BoxDecoration(
                                  color: colorSchema?.grayscaleWhite,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: AppFormField(
                                        value: state.commentInput,
                                        onChanged: (value) {
                                          context.read<CommentBloc>().add(
                                            CommentEvent.changeCommentInput(value),
                                          );
                                        },
                                        controller: _commentController,
                                        decoration: const InputDecoration(
                                          hintText: 'Type your comment',
                                        ),
                                        centerVertical: true,
                                      ),
                                    ),
                                    const Gap(5),
                                    InkWell(
                                      onTap: state.enableSendComment
                                          ? () {
                                        context.read<CommentBloc>().add(
                                            CommentEvent.sendComment(newsId));
                                      }
                                          : null,
                                      child: Assets.icons.iconSendComment.svg(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ),
      ),
    );
  }
}
