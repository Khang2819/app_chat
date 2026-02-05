import 'package:app_chat/presentation/blocs/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/app_loader.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/button.dart';
import '../widgets/button_outline.dart';
import '../widgets/textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppLoader.wrap(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              AppLoader.show(context);
            } else {
              AppLoader.hide(context);
            }
            if (state is AuthSuces) {
              AppSnackbar.show(context, message: 'Đăng nhập thành công');
              context.go('/mainScreen');
            } else if (state is AuthFailure) {
              AppSnackbar.show(context, message: 'Đăng nhập không thành công');
            }
          },
          child: Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topLeft,
                  colors: [Color(0xFF101622), Color(0xFF111C34)],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E5EFF),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1E5EFF),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Xin chào!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Đăng nhập để tiếp tục kết nối và nhắn tin với bạn bè.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Textfield(
                        hint: 'Ví dụ: user@gmai.com',
                        icon: Icons.email_rounded,
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mật khẩu',
                          style: TextStyle(color: Colors.white54, fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Textfield(
                        hint: 'Nhập mật khẩu của bạn',
                        icon: Icons.lock,
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/forgot'),
                          child: Text(
                            'Quên mật khẩu',
                            style: TextStyle(color: Color(0xFF1E5EFF)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Button(
                        text: 'Đăng nhập',
                        color: Color(0xFF1E5EFF),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            LoginWithEmailEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.white24),
                          ),
                          const SizedBox(width: 10),
                          Text('Hoặc', style: TextStyle(color: Colors.white54)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.white24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonOutline(
                              text: 'Google',
                              icon: FontAwesomeIcons.google,
                              // color: Colors.white24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ButtonOutline(
                              text: 'Apple',
                              icon: FontAwesomeIcons.apple,
                              // color: Colors.white24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bạn chưa có tài khoản? ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () => context.push('/register'),
                            child: const Text(
                              'Đăng ký ngay',
                              style: TextStyle(
                                color: Color(0xFF1E5EFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
