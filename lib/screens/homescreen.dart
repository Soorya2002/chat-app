import 'package:chat/widgets/usercard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/auth/auth_services.dart';
import 'package:chat/services/user_service.dart';
import 'chat_screen.dart';
import '../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  final AuthServices _authService = AuthServices();
  final UserService _userService = UserService();

  void logOut(BuildContext context) async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Chat.com',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 73, 158, 118),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu_outlined, color: Colors.white),
            onSelected: (value) {
              if (value == 'logout') {
                logOut(context);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 73, 158, 118),
                    ),
                    SizedBox(width: screenHeight * .01),
                    const Text(
                      'Logout',
                      style:
                          TextStyle(color: Color.fromARGB(255, 73, 158, 118)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: _userService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          final users = snapshot.data!
              .where((user) => user.uid != currentUser?.uid)
              .toList();

          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, index) => Divider(
              height: screenHeight * .007,
              color: Colors.white,
            ),
            itemBuilder: (context, index) {
              final user = users[index];
              return Column(
                children: [
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  UserCard(
                    user: user,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(receiverId: user.uid),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
