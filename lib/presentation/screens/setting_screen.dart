import 'package:app_chat/presentation/blocs/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/app_loader.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/button.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/icon_button.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLoader.wrap(
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
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                AppLoader.show(context);
                return;
              }

              AppLoader.hide(context);

              if (state is AuthSuces &&
                  state.message == 'Đăng xuất thành công') {
                AppSnackbar.show(context, message: state.message);
                // Dùng go thay vì push để xóa toàn bộ stack
                context.go('/login');
              } else if (state is AuthFailure) {
                AppSnackbar.show(context, message: state.error);
              }
            },
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Cài đặt',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(16),
                      children: [
                        Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.2),
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xFF1C232E),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              'https://jbagy.me/wp-content/uploads/2025/03/Hinh-anh-avatar-nam-anime-7.jpg',
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nguyễn Văn Khang',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          '@khang_2819',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              CircleIconButton(
                                onPressed: () {
                                  context.push('/qr_screen');
                                },
                                color: Color(0xFF1E5EFF),
                                icon: Icons.qr_code_scanner,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'TÀI KHOẢN & BẢO VỆ',
                          style: TextStyle(
                            color: Color(0xFF5D675F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey, width: 0.2),
                            color: Color(0xFF1C232E),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.blue.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                title: const Text(
                                  'Tài khoản',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: const Text(
                                  'Bảo mật, đổi mật khẩu',
                                  style: TextStyle(color: Colors.white54),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white38,
                                ),
                                onTap: () {},
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 72),
                                child: Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: Colors.white12,
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.blue.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                title: const Text(
                                  'Tài khoản',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: const Text(
                                  'Bảo mật, đổi mật khẩu',
                                  style: TextStyle(color: Colors.white54),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white38,
                                ),
                                onTap: () {},
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 72),
                                child: Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: Colors.white12,
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.blue.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                title: const Text(
                                  'Tài khoản',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: const Text(
                                  'Bảo mật, đổi mật khẩu',
                                  style: TextStyle(color: Colors.white54),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white38,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'PREFERENCES',
                          style: TextStyle(
                            color: Color(0xFF5D675F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Button(
                          text: 'Đăng xuất',
                          color: Color(0xFF1E5EFF),
                          onPressed: () async {
                            final confirm = await showConfirmDialog(
                              context: context,
                              title: 'Xác nhận đăng xuất',
                              content: 'Bạn có chắc chắn muốn đăng xuất không?',
                            );

                            if (confirm == true) {
                              // ignore: use_build_context_synchronously
                              print("abc 1111");
                              if (!context.mounted) return;
                              context.read<AuthBloc>().add(Logout());
                            }
                          },
                        ),
                      ],
                    ),
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
