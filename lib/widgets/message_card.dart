import 'package:flutter/material.dart';
import 'package:chat/models/message_model.dart';

class MessageCard extends StatelessWidget {
  final MessageModel message;
  final bool isCurrentUser;

  const MessageCard({
    Key? key,
    required this.message,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.8,
        ),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? const Color.fromARGB(255, 73, 158, 118)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
              ),
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
