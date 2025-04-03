import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/shared/extension/theme_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../base/base_page.dart';
import '../../../resources/colors.dart';
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: SvgPicture.asset('assets/images/HelloAgain.svg'),
            ),
            SizedBox(
              height: 60,
              width: 222,
              child: Text(
                'Welcome back you\'ve\nbeen missed',
                style: Theme.of(context).own()?.textTheme?.h1,
              ),
            ),
            const SizedBox(height: 48),

            // Username field
            Row(
              children: [
                Text('Username', style: Theme.of(context).own()?.textTheme?.h2),
                Text('*', style: Theme.of(context).own()?.textTheme?.h2),
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
              ),
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Text('Password', style: Theme.of(context).own()?.textTheme?.h2),
                Text('*', style: Theme.of(context).own()?.textTheme?.h2),
              ],
            ),
            const SizedBox(height: 4),
            TextField(
              controller: passwordController, // Gắn controller
              obscureText: true,
              decoration: InputDecoration(
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    // Xử lý sự kiện khi bấm vào
                  },

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
                            ? Icon(Icons.check, size: 14, color: Colors.white)
                            : null,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Remember me',
                  style: Theme.of(context).own()?.textTheme?.h2,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot the password ?',
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
                  final username = usernameController.text;
                  final password = passwordController.text;

                  // Gửi sự kiện đến LoginBloc
                  context.read<LoginBloc>().add(
                    LoginEvent.login(username: username, password: password),
                  );
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Or continue with
            Center(
              child: Text(
                'or continue with',
                style: Theme.of(context).own()?.textTheme?.h2,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialLoginButton(
                  icon: 'assets/images/facebook.svg',
                  label: 'Facebook',
                  onPressed: () {},
                ),
                Spacer(),
                _socialLoginButton(
                  icon: 'assets/images/google.svg',
                  label: 'Google',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Sign up text
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'don\'t have an account? ',
                  style: Theme.of(context).own()?.textTheme?.h2,
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
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
    );
  }

  Widget _socialLoginButton({
    required String icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 174,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 21, height: 21, child: SvgPicture.asset(icon)),

            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 22 / 14,
                color: AppColors.grayScalee,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
