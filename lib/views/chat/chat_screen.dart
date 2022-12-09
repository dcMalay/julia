import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/views/chat/components/chat_tile.dart';
import 'package:julia/views/login_register/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var status;
  void isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  void initState() {
    isloggedIn();
    print(status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: status == true
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: greenColor,
                  centerTitle: true,
                  title: Text(
                    'chat'.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                body: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 8),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListTileChat(),
                      )
                    ]),
              )
            : Center(
                child: CupertinoButton(
                    color: greenColor,
                    child: const Text('Login to continue'),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(1, 0), end: Offset.zero)
                                .animate(animation),
                            child: child,
                          );
                        },
                      ));
                    }),
              ));
  }
}
