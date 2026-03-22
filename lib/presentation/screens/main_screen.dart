import 'package:app_chat/presentation/screens/directory.dart';
import 'package:app_chat/presentation/screens/friendrequestscreen.dart';
import 'package:app_chat/presentation/screens/home_screen.dart';
import 'package:app_chat/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/bottomnav.dart';
import 'story_screen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int index = 0;
  final List<Widget> _pages = [
    Home(),
    Directory(),
    Friendrequestscreen(),
    StoryScreen(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: Bottomnav(
        currentIndex: index,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
      ),
    );
  }
}
