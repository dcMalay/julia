import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/get_all_messages_model.dart';

// ignore: must_be_immutable
class Chatting extends StatefulWidget {
  const Chatting({Key? key, required this.sellerName}) : super(key: key);
  final String sellerName;
  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  TextEditingController messageController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  List<Allmessage> messages = [];

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
          children: [
            const Expanded(
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
                title: Text(widget.sellerName),
                // subtitle: Text('2BHk flat for sale'),
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
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: GroupedListView<Allmessage, DateTime>(
            padding: const EdgeInsets.all(8),
            reverse: false,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            elements: messages,
            groupBy: (message) => DateTime(
              message.time.year,
              message.time.month,
              message.time.day,
            ),
            groupHeaderBuilder: (Allmessage message) => SizedBox(
              height: 40,
              child: Center(
                child: Card(
                  color: greenColor,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '31/10/2022',
                      // DateFormat.yMMMd().format(message.date),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Allmessage message) => Align(
              alignment: message.reciverId !=
                      _secureStorage.read(key: 'userId').toString()
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(message.message),
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
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
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
                    final message = Allmessage(
                      message: text,
                      time: DateTime.now(),
                    );
                    setState(
                      () => messages.add(message),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  setState(
                    () => messages.add(messageController.text as Allmessage),
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: greenColor,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
