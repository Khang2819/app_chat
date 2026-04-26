import 'package:app_chat/presentation/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../cubits/RegisterCubit/register_cubit.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/button.dart';
import '../widgets/button_outline.dart';
import '../widgets/textfield.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppLoader.wrap(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocListener<RegisterCubit, RegisterCubitState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              AppLoader.show(context);
            } else {
              AppLoader.hide(context);
            }
            if (state is RegisterSuccess) {
              AppSnackbar.show(
                context,
                message: "Đăng ký thành công",
                type: SnackbarType.success,
              );
              context.go('/login');
            } else if (state is RegisterFailure) {
              AppSnackbar.show(
                context,
                message: 'Đăng kí không thành công',
                type: SnackbarType.error,
              );
            }
          },
          child: Scaffold(
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF101622), Color(0xFF111C34)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topLeft,
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Text(
                        'Tạo tài khoản',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Kết nối với bạn bè ngay lập tức. Tham gia cộng đồng ngay hôm nay!',
                        style: TextStyle(color: Colors.white70, fontSize: 17),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Tên đầy đủ',
                        style: TextStyle(fontSize: 15, color: Colors.white54),
                      ),
                      const SizedBox(height: 10),
                      Textfield(
                        hint: 'Nhập đầy đủ tên của bạn',
                        icon: Icons.person,
                        controller: fullNameController,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Email',
                        style: TextStyle(fontSize: 15, color: Colors.white54),
                      ),
                      const SizedBox(height: 10),
                      Textfield(
                        hint: 'Nhập email của bạn',
                        icon: Icons.email_rounded,
                        controller: emailController,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Mật khẩu',
                        style: TextStyle(fontSize: 15, color: Colors.white54),
                      ),
                      const SizedBox(height: 10),
                      Textfield(
                        hint: 'Tạo mật khẩu',
                        icon: Icons.lock,
                        controller: passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Xác nhận mật khẩu',
                        style: TextStyle(fontSize: 15, color: Colors.white54),
                      ),
                      const SizedBox(height: 10),
                      Textfield(
                        hint: 'Nhập lại mật khẩu của bạn',
                        icon: Icons.lock_reset,
                        controller: comfirmController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 30),
                      Button(
                        text: 'Đăng kí',
                        color: Color(0xFF1E5EFF),
                        onPressed: () {
                          context.read<RegisterCubit>().register(
                            fullNameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
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
                          const Text(
                            'Hoặc tiếp tục với',
                            style: TextStyle(color: Colors.white54),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.white24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bạn đã có tài khoản chưa? ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          GestureDetector(
                            onTap: () => context.push('/login'),
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                color: Color(0xFF1E5EFF),
                                fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
