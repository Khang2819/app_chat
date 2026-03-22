import 'dart:ui';

import 'package:flutter/material.dart';

import '../widgets/button.dart';

class UserInfoScreen extends StatelessWidget {
  final String userId;
  const UserInfoScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Xác nhận kết bạn',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF101622), Color(0xFF111C34)],
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            // ignore: deprecated_member_use
                            Colors.white.withOpacity(0.1),
                            // ignore: deprecated_member_use
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                // ignore: deprecated_member_use
                                color: Colors.white.withOpacity(0.8),
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(
                                'https://jbagy.me/wp-content/uploads/2025/03/Hinh-anh-avatar-nam-anime-7.jpg',
                              ),
                            ),
                          ),

                          SizedBox(height: 24),
                          Text(
                            'Nguyễn Văn Khang',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Icon(Icons.person, color: Colors.white),
                          const SizedBox(height: 10),
                          Text(
                            '@khang28_19.',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle add friend
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2962FF),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: Color(0xFF2962FF).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Thêm bạn',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Button(
                      onPressed: () {},
                      text: 'Thêm bạn',
                      color: Colors.blue,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'THÔNG TIN ĐƯỢC TÌM THẤY QUA MÃ QR',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
