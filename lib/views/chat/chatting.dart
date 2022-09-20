import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Chatting extends StatefulWidget {
  const Chatting({Key? key}) : super(key: key);

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  TextEditingController messageController = TextEditingController();

  List<Message> messages = [
    Message(
      text: 'Hi, harvey where are you now a days?',
      date: DateTime.now().subtract(const Duration(days: 6, minutes: 3)),
      isSendByMe: false,
    ),
    Message(
      text: 'I am in USA',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 10)),
      isSendByMe: true,
    ),
    Message(
      text: 'okk, what about your product?',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 11)),
      isSendByMe: true,
    ),
    Message(
      text: 'i was purchased the product a month ago',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 2)),
      isSendByMe: false,
    ),
    Message(
      text: 'But I have some problen with the product',
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 3)),
      isSendByMe: false,
    ),
    Message(
      text: 'Ok then tell about the problems',
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 8)),
      isSendByMe: true,
    ),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
              flex: 0,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text('Babu Rao'),
                subtitle: Text('2BHk flat for sale'),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            itemBuilder: (context) => [
              // popupmenu item 1
              const PopupMenuItem(value: 1, child: Text("Delete Chat")),
              // popupmenu item 2
              const PopupMenuItem(value: 2, child: Text("Report User")),
              const PopupMenuItem(value: 3, child: Text("Block User")),
            ],
            // offset: const Offset(0, 100),
            // color: Colors.grey,
            // elevation: 2,
          ),
        ],
      ),

      body: Column(children: [
        Expanded(
          child: GroupedListView<Message, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: true,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (message) => DateTime(
              message.date.year,
              message.date.month,
              message.date.day,
            ),
            groupHeaderBuilder: (Message message) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      DateFormat.yMMMd().format(message.date),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Message message) => Align(
              alignment: message.isSendByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.text),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey))),
            child: Row(children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(fontSize: 20),
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type Your message',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (text) {
                    final message = Message(
                        text: text, date: DateTime.now(), isSendByMe: true);
                    setState(
                      () => messages.add(message),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.send,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          ),
        )
      ]),

      // body: Stack(children: [

      //   Container(
      //     alignment: Alignment.bottomCenter,
      //     width: MediaQuery.of(context).size.width,
      //     child: Container(
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 10,
      //         vertical: 10,
      //       ),
      //       width: MediaQuery.of(context).size.width,
      //       decoration: const BoxDecoration(
      //           border: Border(top: BorderSide(color: Colors.grey))),
      //       child: Row(children: [
      //         Expanded(
      //             child: TextField(
      //           style: const TextStyle(fontSize: 20),
      //           controller: messageController,
      //           decoration: const InputDecoration(
      //             hintText: 'Type Your message',
      //             hintStyle: TextStyle(
      //               color: Colors.grey,
      //               fontSize: 20,
      //             ),
      //             border: InputBorder.none,
      //           ),
      //         )),
      //         const SizedBox(
      //           width: 12,
      //         ),
      //         const CircleAvatar(
      //           radius: 20,
      //           backgroundColor: Colors.green,
      //           child: Padding(
      //             padding: EdgeInsets.only(left: 5.0),
      //             child: Icon(
      //               Icons.send,
      //               size: 30,
      //               color: Colors.white,
      //             ),
      //           ),
      //         )
      //       ]),
      //     ),
      //   )
      // ]),
    );
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSendByMe;

  Message({
    required this.text,
    required this.date,
    required this.isSendByMe,
  });
}
