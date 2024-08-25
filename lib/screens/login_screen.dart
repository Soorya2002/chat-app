import 'package:chat/auth/auth_services.dart';
import 'package:chat/screens/homescreen.dart';
import 'package:chat/screens/signup_screen.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:chat/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthServices();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Error'),
          content: Text(e.toString()),
        ),
      );
    }
  }

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .2,
            ),
            Image.asset(
              'assets/images/chat.png',
              height: screenHeight * .25,
            ),
            Text(
              'Chat.com',
              style: TextStyle(
                  color: const Color.fromARGB(255, 73, 158, 118),
                  fontSize: screenHeight * .045,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: screenHeight * .04,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
              leadingIcon: const Icon(
                Icons.person,
              ),
              trailingIcon: null,
            ),
            CustomTextField(
              controller: _passController,
              hintText: 'Password',
              leadingIcon: const Icon(
                Icons.lock,
              ),
              isPassword: true,
            ),
            SizedBox(
              height: screenHeight * .04,
            ),
            CustomButton(
              text: 'Sign In',
              onPressed: () {
                login(context);
              },
            ),
            SizedBox(height: screenHeight * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have account?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: const Text(
                    " Sign Up",
                    style: TextStyle(
                        color: Color.fromARGB(255, 73, 158, 118),
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
