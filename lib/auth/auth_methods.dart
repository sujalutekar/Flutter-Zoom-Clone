// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom_clone/pages/home_page.dart';
import 'package:zoom_clone/utils/show_alert_dialog.dart';

class AuthMethods with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // global isLoading
  bool isLoading = false;

  Stream<User?> get authChanges => _firebaseAuth.authStateChanges();

  User get user => _firebaseAuth.currentUser!;

  // Sign In with Google
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      isLoading = true;
      notifyListeners();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;

      // Storing data in cloud firestore
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firebaseFirestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'email': user.email,
            'uid': user.uid,
            'photoUrl': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context, e.message!);
      res = false;
    }

    isLoading = false;
    notifyListeners();

    return res;
  }

  // Sign In Method Using Email and Password
  Future<void> signIn(String emailController, String passwordController,
      BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      if (emailController.isEmpty || passwordController.isEmpty) {
        showAlertDialog(context, 'Fill Required Fields');
      } else {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController,
          password: passwordController,
        )
            .then((value) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context, e.code);
    }

    isLoading = false;
    notifyListeners();
  }

  // Sign Up with email and password
  Future<void> signUp(
      String nameController,
      String emailController,
      String passwordController,
      String confirmPasswordController,
      BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      if (nameController.isEmpty ||
          emailController.isEmpty ||
          passwordController.isEmpty ||
          confirmPasswordController.isEmpty) {
        showAlertDialog(context, 'Fill required fields');
      } else if (passwordController != confirmPasswordController) {
        showAlertDialog(context, 'Confirm Password do not match');
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController,
          password: passwordController,
        )
            .then((value) {
          // adding user to cloud firestore
          FirebaseFirestore.instance
              .collection('users')
              .doc(value.user!.uid)
              .set({
            'username': nameController,
            'email': emailController,
            'uid': value.user!.uid,
            'photoUrl': '',
          });

          // navigating to home page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context, e.code);
    }

    isLoading = false;
    notifyListeners();
  }

  // Sign Out
  void signOut(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.signOut();
      print('Sign Out');
    } catch (e) {
      showAlertDialog(context, e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}
