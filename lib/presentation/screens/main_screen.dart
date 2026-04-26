import 'package:app_chat/presentation/screens/directory.dart';
import 'package:app_chat/presentation/screens/friendrequestscreen.dart';
import 'package:app_chat/presentation/screens/home_screen.dart';
import 'package:app_chat/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/nav/bottom_nav_cubit.dart';
import '../widgets/bottomnav.dart';
import 'story_screen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final List<Widget> _pages = [
    Home(),
    Directory(),
    Friendrequestscreen(),
    StoryScreen(),
    Setting(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: _pages[state],
            bottomNavigationBar: Bottomnav(
              currentIndex: state,
              onTap: (newIndex) {
                context.read<BottomNavCubit>().changeTab(newIndex);
              },
            ),
          );
        },
      ),
    );
  }
}
