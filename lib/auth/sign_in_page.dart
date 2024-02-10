import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_clone/auth/auth_methods.dart';
import 'package:zoom_clone/pages/home_page.dart';
import 'package:zoom_clone/utils/colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String isEmailFilled = '';
  String isPasswordFilled = '';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _authMethods.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12)
                      .copyWith(bottom: 8),
                  child: const Text(
                    'Enter your email address',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                // Email TextField
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.grey.shade700),
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
                          borderSide:
                              BorderSide(color: secondaryBackgroundColor)),
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
                          borderSide:
                              BorderSide(color: secondaryBackgroundColor)),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: secondaryBackgroundColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sign In Button
                      ElevatedButton(
                        onPressed: () => _authMethods.signIn(
                          _emailController.text,
                          _passwordController.text,
                          context,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: (isEmailFilled.isNotEmpty &&
                                  isPasswordFilled.isNotEmpty)
                              ? buttonColor
                              : secondaryBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: (isEmailFilled.isNotEmpty &&
                                      isPasswordFilled.isNotEmpty)
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          print('Clicked on Forget Password');
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
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
                          bool res =
                              await _authMethods.signInWithGoogle(context);
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
                                    image:
                                        AssetImage('assets/images/google.png'),
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
