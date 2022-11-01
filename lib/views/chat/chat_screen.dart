import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/views/chat/components/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        centerTitle: true,
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return const ListTileChat();
            },
          ),
        ],
      ),
    );
  }
}
