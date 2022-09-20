import 'package:flutter/material.dart';
import 'package:julia/views/chat/components/chat_tile.dart';


class ChatScreenBuying extends StatelessWidget {
  const ChatScreenBuying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ListTileChat();
          },
        ),
      ],
    );
  }
}