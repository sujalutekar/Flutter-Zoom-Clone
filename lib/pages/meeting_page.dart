import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:zoom_clone/auth/auth_methods.dart';
import 'package:zoom_clone/pages/join_meeting_page.dart';
import 'package:zoom_clone/pages/video_conference_page.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthMethods _authMethods = AuthMethods();

    return SafeArea(
      child: Column(
        children: [
          AppBar(
            backgroundColor: backgroundColor,
            title: const Text(
              'Meetings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMeetingButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        var random = Random();
                        String roomName =
                            (random.nextInt(10000000) + 10000000).toString();

                        return VideoConferencePage(
                          conferenceID: roomName,
                          userId: _authMethods.user.uid,
                          username: _authMethods.user.displayName.toString(),
                          roomTitle: 'ID: $roomName',
                        );
                      },
                    ),
                  );
                },
                text: 'Meeting',
                icon: Icons.videocam,
                color: Colors.deepOrange,
              ),
              HomeMeetingButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const JoinMeeting();
                      },
                    ),
                  );
                },
                text: 'Join Meeting',
                icon: Icons.add_box_rounded,
              ),
              HomeMeetingButton(
                onTap: () {},
                text: 'Schedule',
                icon: Icons.calendar_today,
              ),
              HomeMeetingButton(
                onTap: () {},
                text: 'Share Screen',
                icon: Icons.arrow_upward_rounded,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 20),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(_authMethods.user.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        String username = snapshot.data?.get('username') ?? '';

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return const Text('No Data');
                        }

                        return Text(
                          'UserName: $username',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        );
                      }),
                  const Spacer(),
                  const Text(
                    'Create/Join Meetings with just a click!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
