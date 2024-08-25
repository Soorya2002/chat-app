import 'package:chat/models/message_model.dart';
import 'package:chat/services/chat_services.dart';
import 'package:chat/services/user_service.dart';
import 'package:chat/widgets/message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  ChatScreen({super.key, required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final UserService _userService = UserService();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void sendMessage() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await _chatService.sendMessage(
        widget.receiverId,
        _messageController.text,
      );
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return FutureBuilder<UserModel>(
      future: _userService.getUserById(widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Chat')),
            body: const Center(child: Text('User not found.')),
          );
        }

        final receiver = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              receiver.email,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 73, 158, 118),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/wallpaper.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                    stream: _chatService.getMessages(
                        currentUser!.uid, widget.receiverId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No messages.'));
                      }

                      final messages = snapshot.data!;
                      return ListView.builder(
                        controller: _scrollController,
                        reverse: false,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isCurrentUser =
                              message.senderId == currentUser.uid;
                          return MessageCard(
                            message: message,
                            isCurrentUser: isCurrentUser,
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'Type your message',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send,
                                  color: Color.fromARGB(255, 73, 158, 118)),
                              onPressed: sendMessage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
