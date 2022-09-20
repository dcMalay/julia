import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
              )),
          title: const Text(
            'Settings',
            style: TextStyle(
              color: Colors.black,
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
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Privacy',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Notification',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Log Out From all device',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Delete Account',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Chat Safety Tips',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }
}
