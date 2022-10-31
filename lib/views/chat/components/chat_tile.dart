import 'package:flutter/material.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:julia/data/repository/get_user_details_repo.dart';
import 'package:julia/views/chat/chatting.dart';
import 'package:julia/views/chat/chatting_screen.dart';

class ListTileChat extends StatefulWidget {
  const ListTileChat({Key? key}) : super(key: key);

  @override
  State<ListTileChat> createState() => _ListTileChatState();
}

class _ListTileChatState extends State<ListTileChat> {
  late Future<Userdetails> sellerData;
  @override
  void initState() {
    super.initState();
    sellerData = getSellerDetails('6357b4a7e7a43f3066b007b7');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Userdetails>(
        future: sellerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Userdetails? seller = snapshot.data;
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ChattingScreen(
                                sellerName: seller!.data[0].userName),
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
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png')
                          // image: NetworkImage(
                          //     "http://52.67.149.51/uploads/${seller!.data[0].userImage}"),
                          ),
                    ),
                  ),
                  title: Text(seller!.data[0].userName),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Click to see the message",
                          style: TextStyle(color: Colors.grey)),
                      // Text(
                      //   "Hi, I am looking for a new house in the south of the city",
                      //   style: TextStyle(fontSize: 12),
                      // ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        });
  }
}
