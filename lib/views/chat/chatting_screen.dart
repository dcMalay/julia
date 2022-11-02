import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/get_all_messages_model.dart';
import 'package:julia/data/repository/messages_repo.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen(
      {super.key, required this.sellerName, required this.sellerId});
  final String sellerName;
  final String sellerId;
  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late Future<List<Allmessage>> allMessage;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  TextEditingController messageController = TextEditingController();
  var user;
  void getuserid() async {
    var authUser = await _secureStorage.read(key: 'userId');
    setState(() {
      user = authUser;
    });
    print(user);
  }

  @override
  void initState() {
    super.initState();

    allMessage = getallMessages();

    getuserid();
  }

  // void startTimer() {
  //   Timer(const Duration(seconds: 2), () {
  //     print('run');
  //     setState(() {
  //       allMessage = getallMessages();
  //     }); //It will redirect  after 3 seconds
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('koefornf');
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
                subtitle: const Text('Seller'),
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
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 8.2 / 10,
            child: FutureBuilder<List<Allmessage>>(
                future: allMessage,
                builder: (context, snapshot) {
                  List<Allmessage>? data = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          var currentItem = data[index];
                          var str = currentItem.time.toString();
                          var parts = str.split(' ');
                          var date = parts[0].trim();
                          var prefix = parts[1].trim();
                          var time = prefix.split('.');
                          var timepre = time[0].trim();

                          return Column(
                            children: [
                              Align(
                                alignment: currentItem.reciverId == user
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Stack(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text(currentItem.message),
                                      ),
                                    ),
                                    Text(
                                      date,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Text(
                                        timepre,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error occur"));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: greenColor,
                      ),
                    );
                  }
                }),
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
                    },
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () {
                    print('send');
                    sendMessages(widget.sellerId, user, messageController.text);
                    messageController.clear();
                    setState(() {
                      allMessage = getallMessages();
                    });
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
        ],
      ),
    );
  }
}
