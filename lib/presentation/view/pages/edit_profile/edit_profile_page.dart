import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_page.dart';
import 'edit_profile_bloc.dart';

@RoutePage()
class EditProfilePage extends BasePage<EditProfileBloc, EditProfileEvent, EditProfileState> {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<EditProfileBloc>().add(const EditProfileEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}