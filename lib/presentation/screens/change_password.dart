import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/textfield.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Đổi mật khẩu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Mât khẩu hiện tại',
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
                        Text(
                          'Mât khẩu mới',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Textfield(
                          hint: 'Nhập mật khẩu hiện tại',
                          icon: Icons.key,
                          controller: newPasswordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        Text(
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
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.info, color: Color(0xFF1E5EFF)),
                                  const SizedBox(width: 20),
                                  Text(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF1E5EFF),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Tối thiểu 8 kí tự',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF1E5EFF),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Có chữ in hoa và chữ thường',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF1E5EFF),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Chứa ít nhất một chữ số',
                                    style: TextStyle(color: Colors.white54),
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
                          onPressed: () {},
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
    );
  }
}
