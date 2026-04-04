import 'package:app_chat/presentation/blocs/auth/auth_event.dart';
import 'package:app_chat/presentation/blocs/my_qr/my_qr_bloc.dart'; // Import MyQrBloc
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
          decoration: const BoxDecoration(
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
                context.go('/login');
              } else if (state is AuthFailure) {
                AppSnackbar.show(
                  context,
                  message: state.error,
                  type: SnackbarType.error,
                );
              }
            },
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Cài đặt',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        BlocBuilder<MyQrBloc, MyQrState>(
                          builder: (context, state) {
                            String fullName = "Đang tải...";
                            String userName = "@...";
                            String? avatarUrl;

                            if (state is MyQrLoaded) {
                              fullName = state.user.fullName;
                              userName = "@${state.user.userName}";
                              avatarUrl = state.user.avatar;
                            }

                            return Container(
                              height: 100,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white10,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xFF1C232E),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            avatarUrl != null &&
                                                    avatarUrl.isNotEmpty
                                                ? NetworkImage(avatarUrl)
                                                : const NetworkImage(
                                                  'https://via.placeholder.com/150',
                                                ),
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            fullName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            userName,
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  CircleIconButton(
                                    onPressed: () => context.push('/qr_screen'),
                                    color: const Color(0xFF1E5EFF),
                                    icon: Icons.qr_code_scanner,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'TÀI KHOẢN & BẢO MẬT',
                          style: TextStyle(
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildSettingGroup([
                          _buildListTile(
                            icon: Icons.lock_outline,
                            title: 'Đổi mật khẩu',
                            subtitle: 'Thay đổi mật khẩu định kỳ',
                            onTap: () => context.push('/change_password'),
                          ),
                          _buildListTile(
                            icon: Icons.notifications_none,
                            title: 'Thông báo',
                            subtitle: 'Âm thanh, tin nhắn',
                            onTap: () {},
                          ),
                        ]),
                        const SizedBox(height: 25),
                        const Text(
                          'KHÁC',
                          style: TextStyle(
                            color: Colors.white38,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildSettingGroup([
                          _buildListTile(
                            icon: Icons.help_outline,
                            title: 'Hỗ trợ',
                            subtitle: 'Trung tâm trợ giúp',
                            onTap: () {},
                          ),
                        ]),
                        const SizedBox(height: 30),
                        Button(
                          text: 'Đăng xuất',
                          color: const Color(0xFF1E5EFF),
                          onPressed: () async {
                            final confirm = await showConfirmDialog(
                              context: context,
                              title: 'Xác nhận',
                              content: 'Bạn có chắc chắn muốn đăng xuất?',
                            );
                            if (confirm == true && context.mounted) {
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

  // Widget bổ trợ để gom nhóm các mục cài đặt
  Widget _buildSettingGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xFF1C232E),
        border: Border.all(color: Colors.white10, width: 0.5),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.blue, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: onTap,
    );
  }
}
