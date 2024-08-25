import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.01,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.015,
        ),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.1,
              backgroundColor: Color.fromARGB(255, 73, 158, 118),
              child: Text(
                user.email[0].toUpperCase(),
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        title: Text(
          user.email,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
