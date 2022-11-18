import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';

import '../notification/notification_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Privacy',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const NotificationScreen(),
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Notification',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              // Divider(
              //   color: Colors.grey,
              // ),
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     'Log Out From all device',
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
              const Divider(
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Delete Account',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Divider(
                color: Colors.grey,
              ),
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     'Chat Safety Tips',
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
              // Divider(
              //   color: Colors.grey,
              // ),
            ],
          ),
        ));
  }
}
