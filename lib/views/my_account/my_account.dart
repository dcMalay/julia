import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:julia/views/myads/myads.dart';
import 'package:julia/views/settings/setting_screen.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final user = FirebaseAuth.instance.currentUser;

  //Get from gallery

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          )),
      body: ListView(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 20,
              ),
              child: InkWell(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30,
                top: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user?.email}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    '+91 9239489823',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 25,
                left: 10,
              ),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Edit Profile"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                              ),
                            ),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              hintText: 'Edit Name',
                            ),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                              hintText: 'Edit Phone No.',
                            ),
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Container(
                            height: 30,
                            width: 50,
                            padding: const EdgeInsets.only(
                              top: 6,
                              left: 10,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit_note_outlined,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  // reverseTransitionDuration: const Duration(seconds: 1),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const MyAds(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(1, 0), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Row(
              children: const [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'My Ads',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20),
          child: Row(
            children: const [
              Icon(
                Icons.settings_outlined,
                color: Colors.grey,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Buy Business',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20),
          child: Row(
            children: const [
              Icon(
                Icons.settings_outlined,
                color: Colors.grey,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Bought Ticket',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20),
          child: Row(
            children: const [
              Icon(
                Icons.settings_outlined,
                color: Colors.grey,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Review & Rating',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  // reverseTransitionDuration: const Duration(seconds: 1),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SettingScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(1, 0), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Row(
              children: [
                const Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      ' change your account Settings',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20),
          child: Row(
            children: [
              const Icon(
                Icons.help_outline_rounded,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Help & Support',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    ' Get helpwith account',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 20),
          child: Row(
            children: [
              const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Log Out"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
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
                            FirebaseAuth.instance.signOut();
                            Navigator.of(ctx).pop();
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
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'logout your profile',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
