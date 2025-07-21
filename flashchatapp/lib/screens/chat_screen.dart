import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/constants.dart';

class ChatScreen extends StatefulWidget {
  static String id = "Chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  User? logged;
  late AnimationController controller;
  late Animation<Color?> backgroundColorAnimation;
  String msg = '';

  @override
  void initState() {
    super.initState();
    _getCurrentUser();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    backgroundColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.blue.shade50,
    ).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> _getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        logged = user;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (msg.trim().isEmpty || logged == null) return;

    await firebaseStore.collection('message').add({
      'text': msg.trim(),
      'sender': logged!.email,
      'timestamp': FieldValue.serverTimestamp(),
    });

    messageController.clear();
    msg = '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message sent'),
        duration: Duration(milliseconds: 800),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorAnimation.value,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.deepPurpleAccent,
        leading: Icon(Icons.bolt, color: Colors.yellowAccent),
        title: Row(
          children: [
            Icon(Icons.chat_bubble_outline, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Flash Chat',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: logged == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: firebaseStore
                          .collection('message')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text("Error loading messages"));
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text("No messages yet"));
                        }
                        final messages = snapshot.data!.docs;

                        final messageWidgets = messages.map((doc) {
                          final text = doc['text'] ?? '';
                          final sender = doc['sender'] ?? '';
                          final isMe = sender == logged!.email;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            child: Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isMe
                                          ? Colors.deepPurpleAccent
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                        bottomLeft: isMe
                                            ? Radius.circular(12)
                                            : Radius.circular(0),
                                        bottomRight: isMe
                                            ? Radius.circular(0)
                                            : Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sender,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: isMe
                                                ? Colors.white70
                                                : Colors.grey.shade600,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          text,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: isMe
                                                ? Colors.white
                                                : Colors.black87,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList();

                        return ListView(
                          reverse: true,
                          padding: EdgeInsets.only(top: 8),
                          children: messageWidgets,
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: kMessageContainerDecoration.copyWith(
                      color: Colors.grey.shade100,
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: Offset(1, 2),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: messageController,
                              onChanged: (value) => msg = value,
                              style: TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.message_outlined,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0),
                        GestureDetector(
                          onTap: sendMessage,
                          child: CircleAvatar(
                            backgroundColor: Colors.deepPurpleAccent,
                            radius: 24,
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
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
  }
}
