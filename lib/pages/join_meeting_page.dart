import 'package:flutter/material.dart';

import 'package:zoom_clone/auth/auth_methods.dart';
import 'package:zoom_clone/pages/video_conference_page.dart';
import 'package:zoom_clone/utils/colors.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({super.key});

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController nameController;
  late TextEditingController idController;
  String isRoomIdFilled = '';

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName ?? "Anonymous",
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    idController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: buttonColor),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          'Join Meeting',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Room Id TextField
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.grey.shade700),
              ),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: idController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  isRoomIdFilled = value;
                });
              },
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryBackgroundColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryBackgroundColor),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: secondaryBackgroundColor)),
                hintText: 'Meeting ID',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: secondaryBackgroundColor,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Name TextField
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.grey.shade700),
              ),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryBackgroundColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryBackgroundColor),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: secondaryBackgroundColor)),
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: secondaryBackgroundColor,
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Join Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ElevatedButton(
              onPressed: () {
                if (isRoomIdFilled.length != 8) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Meeting ID should be of 8 digits',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                  return;
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return VideoConferencePage(
                        conferenceID: idController.text,
                        userId: _authMethods.user.uid,
                        username: _authMethods.user.displayName.toString(),
                        roomTitle: 'ID: ${idController.text}',
                      );
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: (isRoomIdFilled.length == 8)
                    ? buttonColor
                    : secondaryBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  'Join',
                  style: TextStyle(
                    color: (isRoomIdFilled.length == 8)
                        ? Colors.white
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
