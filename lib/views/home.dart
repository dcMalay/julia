import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:julia/views/chat/chat_screen.dart';
import 'package:julia/views/explore/explore.dart';
import 'package:julia/views/home/home_screen.dart';
import 'package:julia/views/my_account/my_account.dart';
import 'package:julia/views/post_products/all_category.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  bool isgetNotification = false;

  List<Widget> currentWidget = [
    const HomeScreen(),
    const ChatScreen(),
    const Categories(),
    const Explore(),
    const MyAccount(),
  ];

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        setState(() {
          isgetNotification = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go close the app?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    height: 30,
                    width: 40,
                    padding: const EdgeInsets.only(
                      top: 6,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    height: 30,
                    width: 40,
                    padding: const EdgeInsets.only(
                      top: 6,
                      left: 8,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: currentWidget[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 10,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.black,
              selectedLabelStyle: const TextStyle(color: Colors.black),
              type: BottomNavigationBarType.fixed,
              onTap: (index) => setState(() {
                _selectedIndex = index;
              }),
              items: [
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.home,
                    size: 28,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Icons.home_outlined,
                    size: 28,
                    color: Colors.black,
                  ),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.message,
                    size: 28,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Icons.message_outlined,
                    size: 28,
                    color: Colors.black,
                  ),
                  label: 'Message',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset('assets/sell.png'),
                  )
                  // icon: CircleAvatar(
                  //   backgroundColor: greenColor,
                  //   radius: 30,
                  //   child: const Icon(
                  //     Ionicons.add,
                  //     color: Colors.white,
                  //     size: 35,
                  //   ),
                  // ),
                  ,
                  label: '',
                ),
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Ionicons.planet,
                    size: 35,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Ionicons.planet_outline,
                    size: 35,
                    color: Colors.black,
                  ),
                  label: 'Explore',
                ),
                const BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.black,
                  ),
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: 28,
                  ),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
