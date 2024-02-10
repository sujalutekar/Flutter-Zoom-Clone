import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_clone/auth/auth_methods.dart';
import 'package:zoom_clone/pages/home_page.dart';
import 'package:zoom_clone/utils/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String isNameFilled = '';
  String isEmailFilled = '';
  String isPasswordFilled = '';
  String isConfirmPassword = '';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authMethods = Provider.of<AuthMethods>(context);

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
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 8),
            child: const Text(
              'Enter your email address',
              style: TextStyle(color: Colors.grey),
            ),
          ),

          // Name TextField
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.grey.shade700),
              ),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  isNameFilled = value;
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
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: secondaryBackgroundColor,
              ),
            ),
          ),

          // Email TextField
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade700),
              ),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  isEmailFilled = value;
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
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: secondaryBackgroundColor,
              ),
            ),
          ),

          // Password TextField
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade700),
              ),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  isPasswordFilled = value;
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
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: secondaryBackgroundColor,
              ),
            ),
          ),

          // Confirm Password
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade700),
              ),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              controller: _confirmPasswordController,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  isConfirmPassword = value;
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
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: secondaryBackgroundColor,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Sign Up Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => _authMethods.signUp(
                    _nameController.text,
                    _emailController.text,
                    _passwordController.text,
                    _confirmPasswordController.text,
                    context,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: (isEmailFilled.isNotEmpty &&
                            isPasswordFilled.isNotEmpty &&
                            isConfirmPassword.isNotEmpty &&
                            isNameFilled.isNotEmpty)
                        ? buttonColor
                        : secondaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: (isEmailFilled.isNotEmpty &&
                                isPasswordFilled.isNotEmpty &&
                                isConfirmPassword.isNotEmpty &&
                                isNameFilled.isNotEmpty)
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'OTHER SIGN IN METHODS',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),

                // Google Sign In Button
                ElevatedButton(
                  onPressed: () async {
                    bool res = await _authMethods.signInWithGoogle(context);
                    if (res) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: secondaryBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            child: const Image(
                              image: AssetImage('assets/images/google.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
