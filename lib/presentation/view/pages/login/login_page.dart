import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../base/base_page.dart';
import '../../../base/page_status.dart';
import '../../../resources/colors.dart';
import '../../../router/router.dart';
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
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    ValueNotifier<String?> usernameError = ValueNotifier<String?>(null);
    ValueNotifier<String?> passwordError = ValueNotifier<String?>(null);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.pageStatus == PageStatus.Error &&
            state.pageErrorMessage != null) {
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
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: SvgPicture.asset('assets/images/HelloAgain.svg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome back you\'ve\nbeen missed',
                    style: Theme.of(context).own()?.textTheme?.h1,
                  ),
                  const SizedBox(height: 48),
                  ValueListenableBuilder<String?>(
                    valueListenable: usernameError,
                    builder: (context, error, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Username',
                                style: Theme.of(context).own()?.textTheme?.h2,
                              ),
                              Text('*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              fillColor: AppColors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              errorText: error,
                              suffixIcon: error != null
                                  ? const Icon(Icons.error, color: Colors.red)
                                  : null,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
            
                  const SizedBox(height: 16),
                  ValueListenableBuilder<String?>(
                    valueListenable: passwordError,
                    builder: (context, error, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Password',
                                style: Theme.of(context).own()?.textTheme?.h2,
                              ),
                              Text('*', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: AppColors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              errorText: error,
                                suffixIcon: IconButton(
                                  icon: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset("assets/images/Icon.png"),
                                  ),
                                  onPressed: () {},
                                ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            shape: BoxShape.rectangle,
                            color: true ? Colors.blue : Colors.transparent,
                          ),
                          child:
                              true
                                  ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Remember me',
                        style: Theme.of(context).own()?.textTheme?.h2,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot the password?',
                          style: TextStyle(color: AppColors.bluee, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 379,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final username = usernameController.text.trim();
                        final password = passwordController.text.trim();
            
                        if (username.isEmpty) {
                          usernameError.value = 'Invalid Username';
                        } else {
                          usernameError.value = null;
                        }
            
                        if (password.isEmpty) {
                          passwordError.value = 'Invalid Password';
                        } else {
                          passwordError.value = null;
                        }
                        if (usernameError.value == null &&
                            passwordError.value == null) {
                          context.read<LoginBloc>().add(
                            LoginEvent.login(
                              username: username,
                              password: password,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueee,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'or continue with',
                      style: Theme.of(context).own()?.textTheme?.h2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _socialLoginButton(
                          icon: 'assets/images/facebook.svg',
                          label: 'Facebook',
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 31,),
                      Expanded(
                        child: _socialLoginButton(
                          icon: 'assets/images/google.svg',
                          label: 'Google',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).own()?.textTheme?.h2,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _socialLoginButton({
    required String icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.grey[100],
        minimumSize: Size.fromHeight(50)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 21, height: 21, child: SvgPicture.asset(icon)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.grayScalee,
            ),
          ),
        ],
      ),
    );
  }
}
