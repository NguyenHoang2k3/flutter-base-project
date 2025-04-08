import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/resources/colors.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../base/base_page.dart';
import '../../../router/router.dart';
import 'edit_profile_bloc.dart';

@RoutePage()
class EditProfilePage
    extends BasePage<EditProfileBloc, EditProfileEvent, EditProfileState> {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<EditProfileBloc>().add(const EditProfileEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return SafeArea(
      child: Padding(padding: EdgeInsets.all(24), child: SizedBox(
        height: 24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.push(const ProfileRoute());
                    },

                    child: Icon(Icons.clear,color: AppColors.grayScale,)
                  ),
                  Text(
                    'Edit Profile',
                    style: Theme.of(context).own()?.textTheme?.h3,
                    ),
                  SvgPicture.asset('assets/images/tick.svg')
                ],
              ),
            ),
            SizedBox(height: 16,),
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: AppColors.white,
                  backgroundImage: AssetImage('assets/images/wilson.png'),
                ),
                Positioned(bottom: 0,right: 17,child: SvgPicture.asset('assets/images/editimage.svg')
                )
              ],
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Text('Username', style: Theme.of(context).own()?.textTheme?.h2),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Text('Full name', style: Theme.of(context).own()?.textTheme?.h2),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),

            SizedBox(height: 16,),
            Row(
              children: [
                Text('Email Address', style: Theme.of(context).own()?.textTheme?.h2),
                Text('*', style: Theme.of(context).own()?.textTheme?.h2?.copyWith(color: AppColors.brickRed)),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Text('Phone Number', style: Theme.of(context).own()?.textTheme?.h2),
                Text('*', style: Theme.of(context).own()?.textTheme?.h2?.copyWith(color: AppColors.brickRed)),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Text('Bio', style: Theme.of(context).own()?.textTheme?.h2),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Text('Website', style: Theme.of(context).own()?.textTheme?.h2),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),

          ],
        ),
      ),

      )
    );
  }
}