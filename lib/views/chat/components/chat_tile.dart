import 'package:flutter/material.dart';
import 'package:julia/views/chat/chatting.dart';

class ListTileChat extends StatelessWidget {
  const ListTileChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                // reverseTransitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Chatting(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  //final tween = Tween(begin: 0.0, end: 1.0);
                  //final fadeAnimation = animation.drive(tween);
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
          leading: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png"))),
          ),
          title: const Text("Babu Rao"),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("2BHK Flat for sale", style: TextStyle(color: Colors.black)),
              Text(
                "Hi, I am looking for a new house in the south of the city",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
