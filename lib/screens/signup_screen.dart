import 'package:chat/auth/auth_services.dart';
import 'package:chat/screens/homescreen.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:chat/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();

  SignupScreen({super.key});

  void register(BuildContext context) async {
    final auth = AuthServices();
    if (_passController.text == _passConfirmController.text) {
      try {
        await auth.signUpWithEmailAndPassword(
            _emailController.text, _passController.text);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Password Mismatch'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .1,
            ),
            Image.asset(
              'assets/images/signup.png',
              height: screenHeight * .3,
            ),
            const Text(
              'Create your account',
              style: TextStyle(
                color: Color.fromARGB(255, 73, 158, 118),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight * .03,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email',
              leadingIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              trailingIcon: null,
            ),
            CustomTextField(
              controller: _passController,
              hintText: 'Password',
              leadingIcon: const Icon(Icons.lock),
              isPassword: true,
            ),
            CustomTextField(
              controller: _passConfirmController,
              hintText: 'Confirm Password',
              leadingIcon: const Icon(Icons.lock),
              isPassword: true,
            ),
            SizedBox(
              height: screenHeight * .04,
            ),
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                register(context);
              },
            ),
            SizedBox(height: screenHeight * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(
                        color: Color.fromARGB(255, 73, 158, 118),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
