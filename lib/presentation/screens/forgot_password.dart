import 'package:app_chat/presentation/cubits/cubit/forgot_password_cubit.dart';
import 'package:app_chat/presentation/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_snackbar.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppLoader.wrap(
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            AppSnackbar.show(
              context,
              message: "Link đặt lại mật khẩu đã được gửi vào Email của bạn!",
            );
            Navigator.pop(context);
          } else if (state is ForgotPasswordFailure) {
            AppSnackbar.show(context, message: "Lỗi: ${state.error}");
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0D1117),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
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
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Đừng lo lắng! Hãy nhập email hoặc số điện thoại của bạn, chúng tôi sẽ gửi mã xác thực để bạn lấy lại mật khẩu.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.55,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Email hoặc Số điện thoại',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Textfield(
                    controller: emailController,
                    hint: 'Ví dụ: user@gmai.com',
                    isPassword: false,
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 30),
                  Button(
                    onPressed: () {
                      context.read<ForgotPasswordCubit>().sendResetEmail(
                        emailController.text.trim(),
                      );
                    },
                    text: 'Gửi email',
                    color: Color(0xFF1E5EFF),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
