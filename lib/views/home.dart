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

  List<Widget> currentWidget = [
    const HomeScreen(),
    const ChatScreen(),
    Categories(),
    Explore(),
    const MyAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentWidget[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                size: 35,
                color: Colors.black,
              ),
              icon: Icon(
                Icons.home_outlined,
                size: 35,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.message,
              size: 35,
              color: Colors.black,
            ),
            icon: Icon(
              Icons.message_outlined,
              size: 35,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 30,
              child: Icon(
                Ionicons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
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
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              size: 35,
              color: Colors.black,
            ),
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 35,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
  //   return Scaffold(
  //       body: currentWidget[_selectedIndex],
  //       bottomNavigationBar: Stack(children: [
  //         Positioned(
  //           bottom: 5,
  //           child: Container(
  //             padding: const EdgeInsets.all(8),
  //             width: MediaQuery.of(context).size.width,
  //             decoration: const BoxDecoration(
  //                 border: Border(top: BorderSide(color: Colors.grey))),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 InkWell(
  //                   onTap: () {
  //                     _onItemTapped(0);
  //                   },
  //                   child: Navbaritem(
  //                       iconName:
  //                           istaped == 0 ? Icons.home : Icons.home_outlined),
  //                 ),
  //                 InkWell(
  //                     onTap: () {
  //                       _onItemTapped(1);
  //                     },
  //                     child: Navbaritem(
  //                         iconName: istaped == 1
  //                             ? Icons.message
  //                             : Icons.message_outlined)),
  //                 GestureDetector(
  //                   onTap: () {
  //                     _onItemTapped(2);
  //                   },
  //                   child: const CircleAvatar(
  //                     backgroundColor: Colors.green,
  //                     radius: 30,
  //                     child: Icon(
  //                       Icons.add,
  //                       size: 40,
  //                     ),
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     _onItemTapped(3);
  //                   },
  //                   child: Navbaritem(
  //                     iconName: istaped == 3
  //                         ? Ionicons.planet
  //                         : Ionicons.planet_outline,
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     _onItemTapped(4);
  //                   },
  //                   child: Navbaritem(
  //                     iconName:
  //                         istaped == 4 ? Icons.person : Icons.person_outlined,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ]));
  // }

  // Widget _showWidget() {
  //   if (_selectedIndex == 1) {
  //     return currentWidget[0];
  //   } else if (_selectedIndex == 2) {
  //     return Container();
  //   } else if (_selectedIndex == 3) {
  //     return Container();
  //   } else if (_selectedIndex == 4) {
  //     return Container();
  //   } else if (_selectedIndex == 5) {
  //     return currentWidget[1];
  //   } else {
  //     return currentWidget[0];
  //   }
  // }
// }

// class Navbaritem extends StatelessWidget {
//   const Navbaritem({
//     super.key,
//     required this.iconName,
//   });

//   final IconData iconName;
//   @override
//   Widget build(BuildContext context) {
//     return Icon(
//       iconName,
//       size: 30,
//     );
//   }
// }

