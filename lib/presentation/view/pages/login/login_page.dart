import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/presentation/view/widgets/app_checkbox.dart';
import 'package:flutter_clean_architecture/shared/extension/context.dart';
import 'package:flutter_clean_architecture/shared/utils/logger.dart';
import '../../../../gen/assets.gen.dart';
import '../../../base/base_page.dart';
import '../../../base/page_status.dart';
import '../../../resources/locale_keys.dart';
import '../../../router/router.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_form_field.dart';
import '../../widgets/app_secure_form_field.dart';
import 'login_bloc.dart';

@RoutePage()
class LoginPage extends BasePage<LoginBloc, LoginEvent, LoginState> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  void onInitState(BuildContext context) {
    context.read<LoginBloc>().add(const LoginEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    final textTheme = context.themeOwn().textTheme;
    final colorSchema = context.themeOwn().colorSchema;

    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final usernameErrorNotifier = ValueNotifier<String?>(null);
    final passwordErrorNotifier = ValueNotifier<String?>(null);
    return  AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light, // iOS
      ),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.pageStatus == PageStatus.Error &&
              state.pageErrorMessage != null) {
            logger.d('a');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.pageErrorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.isLoggedIn) {
            context.router.push(const HomeRoute());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.login_login_hello.tr(),
                          style: textTheme?.textDisplayLargeBold?.copyWith(
                            color: colorSchema?.grayscaleTitleactive,
                          ),
                        ),
                        Text(
                          LocaleKeys.login_login_again.tr(),
                          style: textTheme?.textDisplayLargeBold?.copyWith(
                            color: colorSchema?.primaryDefault,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          LocaleKeys.login_login_title.tr(),
                          style: textTheme?.textLarge?.copyWith(
                            color:Theme.of(context).brightness == Brightness.light ? colorSchema?.grayscaleBodyText : const Color(0xffB0B3B8),
                          ),
                        ),
                        const SizedBox(height: 48),
                        ValueListenableBuilder<String?>(
                          valueListenable: usernameErrorNotifier,
                          builder: (context, errorText, child) {
                            return AppFormField(
                              label: LocaleKeys.login_login_label_username.tr(),
                              isRequire: true,
                              controller: usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LocaleKeys.login_login_error_empty_username.tr();
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorText: errorText,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder<String?>(
                          valueListenable: passwordErrorNotifier,
                          builder: (context, errorText, child) {
                            return AppSecureFormField(
                              label: LocaleKeys.login_login_label_password.tr(),
                              isRequired: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return LocaleKeys.login_login_error_empty_password.tr();
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorText: errorText,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                          AppCheckBox(
                            borderColor: Theme.of(context).brightness == Brightness.light ? colorSchema?.grayscaleBodyText : colorSchema?.darkmodeBody,
                            size: CheckBoxSize.normal,
                            checkedColor: colorSchema?.primaryDefault,
                            value: true,
                          ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                LocaleKeys.login_login_checkbox_remember.tr(),
                                style: textTheme?.textSmall?.copyWith(
                                  color: colorSchema?.grayscaleBodyText,
                                    overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                LocaleKeys.login_login_forgot_password.tr(),
                                style: textTheme?.textSmall?.copyWith(
                                  color: colorSchema?.primaryDefault,
                                  overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),
                        SizedBox(
                          height: 50,
                          child:  AppButton.primary(
                            height: 50,
                            backgroundColor: colorSchema?.primaryDefault,
                            title: LocaleKeys.login_login_login_button.tr(),
                            titleStyle: textTheme?.textMediumLink,
                            onPressed: () {
                              final isValid = formKey.currentState?.validate() ?? false;
                              usernameErrorNotifier.value =
                              usernameController.text.isEmpty
                                  ? LocaleKeys.login_login_error_empty_username.tr()
                                  : null;
            
                              passwordErrorNotifier.value =
                              passwordController.text.isEmpty
                                  ? LocaleKeys.login_login_error_empty_password.tr()
                                  : null;
                              if (isValid) {
                                final username = usernameController.text.trim();
                                final password = passwordController.text.trim();
            
                                context.read<LoginBloc>().add(LoginEvent.login(
                                  username: username,
                                  password: password,
                                ));
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            LocaleKeys.login_login_continue_with_label.tr(),
                            style: textTheme?.textSmall?.copyWith(
                              color: colorSchema?.grayscaleBodyText,
                          ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppButton.primary(
                                height: 48,
                                backgroundColor:
                                colorSchema?.grayscaleSecondaryButton,
                                title: LocaleKeys.login_login_facebook_button.tr(),
                                titleStyle: textTheme?.textMediumLink?.copyWith(
                                  color: const Color(0xff667080),
                                ),
                                onPressed: () {},
                                icon: Assets.icons.facebook.svg(),
                              ),
                            ),
                            const SizedBox(width: 31),
                            Expanded(
                              child: AppButton.primary(
                                backgroundColor:
                                colorSchema?.grayscaleSecondaryButton,
                                title: LocaleKeys.login_login_google_button.tr(),
                                titleStyle: textTheme?.textMediumLink?.copyWith(
                                  color:const Color(0xff667080),
                                ),
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                  LoginEvent.pressGoogleLogin(),
                                );
                                },
                                icon: Assets.icons.goggleIcon.svg(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                LocaleKeys.login_login_don_have_account_label.tr(),
                                style: textTheme?.textSmall?.copyWith(
                                  color: colorSchema?.grayscaleBodyText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                LocaleKeys.login_login_sign_up.tr(),
                                style: textTheme?.textSmallLink?.copyWith(
                                  color: colorSchema?.primaryDefault,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
