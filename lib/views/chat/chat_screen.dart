import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:julia/views/chat/subscreens/buyer_chatscreen.dart';
import 'package:julia/views/chat/subscreens/seller_chatscreen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),
            centerTitle: true,
            title: const Text('Chat',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            elevation: 1.0,
            backgroundColor: Colors.white,
            bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Selling'.toUpperCase(),
                  ),
                  Tab(
                    text: 'Buying'.toUpperCase(),
                  ),
                ]),
          ),
          body: const TabBarView(children: [
            ChatScreenSelling(),
            ChatScreenBuying(),
          ])),
    );
  }
}
