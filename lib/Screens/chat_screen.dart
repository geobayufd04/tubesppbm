import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _database = FirebaseDatabase.instance.reference().child('chats');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _database.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  Object? data = snapshot.data!.snapshot.value;
                  List messages = data?.values.toList();
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(messages[index]['message']),
                    ),
                  );
                }
                return const Center(child: Text('No messages yet.'));
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
                    decoration: const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      _database.push().set({'message': _messageController.text});
                      _messageController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on Object? {
  get values => null;
}
