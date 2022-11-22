import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/views/chat/components/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          centerTitle: true,
          title: const Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(top: 8),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListTileChat(),
              )
            ]),
      ),
    );
  }
}
