import 'package:app_chat/presentation/cubits/cubit/change_password_state.dart';
import 'package:app_chat/presentation/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/cubit/change_password_cubit.dart';
import '../widgets/app_loader.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state.status == ChangePassWord.loading) {
              AppLoader.show(context);
            } else {
              AppLoader.hide(context);
            }
            if (state.status == ChangePassWord.success) {
              AppSnackbar.show(context, message: 'Đổi mật khẩu thành công!');
              context.pop();
            }
            if (state.status == ChangePassWord.failure) {
              AppSnackbar.show(
                context,
                message: state.error ?? 'Lỗi không xác định',
              );
            }
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
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
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16),
                          physics: ClampingScrollPhysics(),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
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
                              const SizedBox(height: 10),
                              const Text(
                                'Đổi mật khẩu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Mật khẩu hiện tại',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Textfield(
                                hint: 'Nhập mật khẩu cũ',
                                icon: Icons.lock,
                                controller: passwordController,
                                isPassword: true,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Mât khẩu mới',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Textfield(
                                hint: 'Nhập mật khẩu mới',
                                icon: Icons.key,
                                controller: newPasswordController,
                                isPassword: true,
                                onChanged: (value) {
                                  context
                                      .read<ChangePasswordCubit>()
                                      .onPasswordChanged(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Xác nhận mật khẩu',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Textfield(
                                hint: 'Xác nhận mật khẩu mới',
                                icon: Icons.check_circle,
                                controller: confirmPasswordController,
                                isPassword: true,
                              ),
                              const SizedBox(height: 30),
                              Container(
                                width: double.infinity,
                                height: 160,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1C232E),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: Color(0xFF1E5EFF),
                                        ),
                                        const SizedBox(width: 20),
                                        const Text(
                                          'Yêu cầu mật khẩu',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          state.hasMinLength
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color:
                                              state.hasMinLength
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        const SizedBox(width: 20),
                                        const Text(
                                          'Tối thiểu 8 kí tự',
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          state.hasUpperLower
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color:
                                              state.hasUpperLower
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        const SizedBox(width: 20),
                                        const Text(
                                          'Có chữ in hoa và chữ thường',
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          state.hasNumber
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color:
                                              state.hasNumber
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        const SizedBox(width: 20),
                                        const Text(
                                          'Chứa ít nhất một chữ số',
                                          style: TextStyle(
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              Button(
                                text: 'Lưu thay đổi',
                                color: Color(0xFF1E5EFF),
                                onPressed: () {
                                  context
                                      .read<ChangePasswordCubit>()
                                      .changePassword(
                                        passwordController.text.trim(),
                                        newPasswordController.text.trim(),
                                      );
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
