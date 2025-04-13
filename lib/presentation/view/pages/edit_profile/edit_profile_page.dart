import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/entities/current_user.dart';
import 'package:flutter_clean_architecture/presentation/resources/colors.dart';
import 'package:flutter_clean_architecture/shared/extension/context.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../base/base_page.dart';
import 'edit_profile_bloc.dart';

@RoutePage()
class EditProfilePage
    extends BasePage<EditProfileBloc, EditProfileEvent, EditProfileState> {
  const EditProfilePage({Key? key}) : super(key: key);

  Future<CurrentUser?> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      return CurrentUser.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> _saveUserProfile(CurrentUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('currentUser', userJson);
  }

  @override
  void onInitState(BuildContext context) {
    context.read<EditProfileBloc>().add(const EditProfileEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;
    final iconColor = Theme.of(context).iconTheme.color;
    return SafeArea(
      child: FutureBuilder<CurrentUser?>(
        future: _loadUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load profile'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user logged in'));
          }

          final user = snapshot.data!;

          final TextEditingController usernameController =
              TextEditingController(text: user.username);
          final TextEditingController fullNameController =
              TextEditingController(text: user.fullName ?? '');
          final TextEditingController emailController = TextEditingController(
            text: user.email,
          );
          final TextEditingController phoneNumberController =
              TextEditingController(text: user.phoneNumber);
          final TextEditingController bioController = TextEditingController(
            text: user.bio ?? '',
          );
          final TextEditingController websiteController = TextEditingController(
            text: user.website ?? '',
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
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
                            context.router.pop();
                          },
                          child: Icon(Icons.clear, color: iconColor),
                        ),
                        Text(
                          'Edit Profile',
                          style: textTheme?.textMediumLink?.copyWith(
                            color: colorSchema?.darkBlack,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState?.validate() != true)
                              return;

                            final updatedUser = CurrentUser(
                              id: user.id,
                              username: usernameController.text,
                              fullName: fullNameController.text,
                              email: emailController.text,
                              phoneNumber: phoneNumberController.text,
                              bio:
                                  bioController.text.isNotEmpty
                                      ? bioController.text
                                      : null,
                              website:
                                  websiteController.text.isNotEmpty
                                      ? websiteController.text
                                      : null,
                              imagePath: user.imagePath,
                            );

                            await _saveUserProfile(updatedUser);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile updated successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            context.router.pop();
                          },
                          child: Icon(Icons.check, color: iconColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: AppColors.white,
                        backgroundImage:
                            user.imagePath != null
                                ? AssetImage(user.imagePath!)
                                : null,
                        child:
                            user.imagePath == null
                                ? const Icon(Icons.person, size: 70)
                                : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 17,
                        child: SvgPicture.asset('assets/images/editimage.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    'Username',
                    usernameController,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Full Name', fullNameController),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    'Email Address',
                    emailController,
                    isRequired: true,
                    enabled: true,
                    isEmail: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context,
                    'Phone Number',
                    phoneNumberController,
                    isRequired: true,
                    isPhone: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Bio', bioController),
                  const SizedBox(height: 16),
                  _buildTextField(context, 'Website', websiteController),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    TextEditingController controller, {
    bool isRequired = false,
    bool enabled = true,
    bool isEmail = false,
    bool isPhone = false,
  }) {
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: textTheme?.textSmall?.copyWith(
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? colorSchema?.grayscaleBodyText
                        : colorSchema?.darkmodeBody,
              ),
            ),
            if (isRequired)
              Text(
                '*',
                style: textTheme?.textSmall?.copyWith(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? colorSchema?.errorDark
                          : colorSchema?.errorDarkmode,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          enabled: enabled,

          decoration: InputDecoration(
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: SizedBox.shrink(),
          ),
          validator: (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return '$label is required';
            }
            if (isEmail &&
                value != null &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Invalid email format';
            }
            if (isPhone &&
                value != null &&
                !RegExp(r'^\d{10,15}$').hasMatch(value)) {
              return 'Invalid phone number';
            }
            return null;
          },
        ),
      ],
    );
  }
}
