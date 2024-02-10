import 'package:flutter/material.dart';

import 'package:zoom_clone/pages/meeting_page.dart';
import 'package:zoom_clone/pages/settings_page.dart';
import 'package:zoom_clone/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  void onTap(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const MeetingPage(),
    const Text(
      'Team Chat',
      style: TextStyle(color: Colors.white),
    ),
    const Text(
      'Mail',
      style: TextStyle(color: Colors.white),
    ),
    const Text(
      'Calendar',
      style: TextStyle(color: Colors.white),
    ),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: backgroundColor,
      //   title: const Text(
      //     'Meet & Chat',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      // ),
      body: pages[_page],
      bottomNavigationBar: Container(
        color: footerColor,
        padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
        child: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade700,
          currentIndex: _page,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.videocam),
              label: 'Meetings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline),
              label: 'Team Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              label: 'Mail',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_rounded),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
