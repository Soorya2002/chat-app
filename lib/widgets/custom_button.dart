import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * .8,
      height: screenHeight * .06,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 73, 158, 118),
            foregroundColor: Colors.transparent,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}
