import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF101622), Color(0xFF111C34)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topLeft,
                    ),
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
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
                                const SizedBox(height: 10),
                                Center(
                                  child: Container(
                                    height: 80,
                                    width: 80,
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
                                    child: Icon(
                                      Icons.chat_rounded,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Quên mật khẩu?',
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Đừng lo lắng! Hãy nhập email của bạn, chúng tôi sẽ gửi mã để bạn đổi lấy mật khẩu',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Textfield(
                                  hint: 'Ví dụ: user@gmail.com',
                                  icon: Icons.email_rounded,
                                  controller: emailController,
                                ),
                                const SizedBox(height: 30),
                                Button(
                                  text: 'Xác nhận',
                                  color: Color(0xFF1E5EFF),
                                  onPressed: () {
                                    // context.read<AuthBloc>().add(

                                    // );
                                  },
                                ),

                                const Spacer(),
                                Center(
                                  child: Text(
                                    'Cần hỗ trợ thêm? ❓',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
