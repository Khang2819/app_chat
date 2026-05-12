import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/button.dart';
import '../widgets/user_avatar.dart';

class ChangeNameAvatar extends StatelessWidget {
  const ChangeNameAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text(
          'Chỉnh sửa thông tin',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0D1117),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFF2A3A4A),
                        width: 4,
                      ),
                    ),
                    child: UserAvatar(
                      isAdd: false,
                      isOnline: false,
                      radius: 60,
                      avatar:
                          'https://jbagy.me/wp-content/uploads/2025/03/Hinh-anh-avatar-nam-anime-7.jpg',
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[300],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Align(
              child: const Text(
                'Nguyễn Văn Khang',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            const SizedBox(height: 5),
            Align(
              child: const Text(
                '@Kan_ne',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),

            const SizedBox(height: 25),

            const Text('Tên', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF1A222C),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Alex Revera',
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),
            const Text('UserName', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF1A222C),
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Alex_Revera',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
            Button(
              onPressed: () {},
              text: 'Lưu để thay đổi',
              color: const Color(0xFF1E5EFF),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
