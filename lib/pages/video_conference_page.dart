import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;
  final String userId;
  final String username;
  final String roomTitle;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
    required this.userId,
    required this.username,
    required this.roomTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID:
            1317753908, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            '96e7d2e7ff4e42253d049cb31411452b3f724c0c03248c754169f5d49d9e8f2e', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userId,
        userName: username,
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(
          topMenuBarConfig: ZegoTopMenuBarConfig(title: roomTitle),
        ),
      ),
    );
  }
}
