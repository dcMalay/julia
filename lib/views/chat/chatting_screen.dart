import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/get_all_messages_model.dart';
import 'package:julia/data/repository/messages_repo.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen(
      {super.key,
      required this.sellerName,
      required this.sellerId,
      required this.sellerprofileImage});
  final String sellerName;
  final String sellerId;
  final String sellerprofileImage;
  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late Future<List<Allmessage>> allMessage;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  TextEditingController messageController = TextEditingController();
  final ScrollController _controller = ScrollController();
  var user;
  Timer? timer;
  //store the user in user variable
  void getuserid() async {
    var authUser = await _secureStorage.read(key: 'userId');
    setState(() {
      user = authUser;
    });
    print('User ------->$user');
  }

  @override
  void initState() {
    super.initState();
    allMessage = getallMessages(widget.sellerId);
    timer = Timer.periodic(
        const Duration(seconds: 3),
        (Timer t) => setState(() {
              allMessage = getallMessages(widget.sellerId);
            }));

    getuserid();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent + 10,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: redColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: widget.sellerprofileImage.isEmpty
                    ? const NetworkImage(
                        'https://www.julia.sr/assets/images/loginEntryPointChat.webp')
                    : NetworkImage(
                        widget.sellerprofileImage.contains('http')
                            ? 'https://www.julia.sr/assets/images/loginEntryPointChat.webp'
                            : widget.sellerprofileImage,
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
        // actions: [
        // PopupMenuButton<int>(
        //   icon: Icon(
        //     Icons.more_vert,
        //     color: redColor,
        //   ),
        //   itemBuilder: (context) => [
        //     const PopupMenuItem(value: 1, child: Text("Delete Chat")),
        //     const PopupMenuItem(value: 2, child: Text("Report User")),
        //     const PopupMenuItem(value: 3, child: Text("Block User")),
        //   ],
        // ),
        // ],
      ),
      body: ListView(
        // reverse: true,
        // shrinkWrap: true,
        controller: _controller,
        children: [
          Padding(
            padding: MediaQuery.of(context).viewInsets * 1 / 60,
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 4 / 5,
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 0),
                                  child: Align(
                                    alignment: currentItem.reciverId == user
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: Stack(
                                      children: [
                                        Card(
                                          elevation: 5,
                                          color: currentItem.reciverId == user
                                              ? Colors.white
                                              : greenColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding:
                                                currentItem.reciverId == user
                                                    ? const EdgeInsets.only(
                                                        top: 15,
                                                        left: 8,
                                                        bottom: 15,
                                                        right: 50)
                                                    : const EdgeInsets.only(
                                                        top: 15,
                                                        right: 8,
                                                        left: 50,
                                                        bottom: 15),
                                            child: Text(
                                              currentItem.message,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: currentItem.reciverId ==
                                                        user
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: 6,
                                          child: Text(
                                            date,
                                            style: TextStyle(
                                                color: currentItem.reciverId ==
                                                        user
                                                    ? Colors.grey
                                                    : Colors.white,
                                                fontSize: 8),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 7,
                                          child: Text(
                                            timepre,
                                            style: TextStyle(
                                                color: currentItem.reciverId ==
                                                        user
                                                    ? Colors.grey
                                                    : Colors.white,
                                                fontSize: 8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 70,
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
                  decoration: InputDecoration(
                    hintText: 'type_your_message'.tr(),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  FlutterRingtonePlayer.playNotification();
                  Timer(const Duration(milliseconds: 200), () {
                    FlutterRingtonePlayer.stop();
                  });

                  print('send');
                  sendMessages(widget.sellerId, user, messageController.text);
                  messageController.clear();
                  setState(() {
                    allMessage = getallMessages(widget.sellerId);
                  });
                  _scrollDown();
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
        ),
      ),
    );
  }
}
