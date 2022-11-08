import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:julia/data/repository/get_user_details_repo.dart';
import 'package:julia/data/repository/message_sender_list_repo.dart';
import 'package:julia/views/chat/chatting_screen.dart';

class ListTileChat extends StatefulWidget {
  const ListTileChat({Key? key}) : super(key: key);

  @override
  State<ListTileChat> createState() => _ListTileChatState();
}

class _ListTileChatState extends State<ListTileChat> {
  late Future<Userdetails> sellerData;
  late Future<List<dynamic>> senderdata;
  late Future<List<Userdetails>> senderdetailslist;
  List listdata = [];
  @override
  void initState() {
    super.initState();
    senderdata = getSenderList();
    getSenderList().then((value) => value.map((e) {
          print(e);

          listdata.addAll(e);
        }));

    // sellerData.then((value) {
    //   return sellerData = getSellerDetails(value.data[0].userId);
    // });
    print('listdata ------->$listdata');
    sellerData = getSellerDetails('6357b4a7e7a43f3066b007b7');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Userdetails>(
        future: sellerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Userdetails? seller = snapshot.data;
            return ListView.builder(
                itemCount: seller!.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ChattingScreen(
                                  sellerName: seller.data[index].userName,
                                  sellerId: '6357b4a7e7a43f3066b007b7',
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                            begin: const Offset(1, 0),
                                            end: Offset.zero)
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
                          title: Text(seller.data[index].userName),
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
                      ),
                      const Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            );
          }
        });
  }
}
