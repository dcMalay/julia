import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/message_sender_model.dart';
import 'package:julia/data/repository/message_sender_list_repo.dart';
import 'package:julia/views/chat/chatting_screen.dart';

class ListTileChat extends StatefulWidget {
  const ListTileChat({Key? key}) : super(key: key);

  @override
  State<ListTileChat> createState() => _ListTileChatState();
}

class _ListTileChatState extends State<ListTileChat> {
  late Future<List<MessageSender>> sellerData;

  @override
  void initState() {
    super.initState();
    sellerData = getmessageSender();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: FutureBuilder<List<MessageSender>>(
          future: sellerData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MessageSender>? seller = snapshot.data;
              return SizedBox(
                height: MediaQuery.of(context).size.height * 4 / 5,
                child: ListView.builder(
                    itemCount: seller!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ChattingScreen(
                                  sellerprofileImage: seller[index].userImage,
                                  sellerName: seller[index].userName,
                                  sellerId: seller[index].userId,
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
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 25,
                                      backgroundColor: const Color.fromARGB(
                                          255, 233, 233, 233),
                                      backgroundImage: NetworkImage(
                                        seller[index].userImage.contains('http')
                                            ? 'https://api.minimalavatars.com/avatar/random/png'
                                            : "https://julia.sr/uploads/${seller[index].userImage}",
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        seller[index].userName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const Text(
                                        'click to view message',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      // return Column(
                      //   children: [
                      //     Expanded(
                      //       child: ListTile(
                      //         onTap: () {
                      //           Navigator.of(context).push(
                      //             PageRouteBuilder(
                      //               transitionDuration:
                      //                   const Duration(milliseconds: 500),
                      //               pageBuilder: (context, animation,
                      //                       secondaryAnimation) =>
                      //                   ChattingScreen(
                      //                 sellerName: seller[index].userName,
                      //                 sellerId: seller[index].userId,
                      //               ),
                      //               transitionsBuilder: (context, animation,
                      //                   secondaryAnimation, child) {
                      //                 return SlideTransition(
                      //                   position: Tween<Offset>(
                      //                           begin: const Offset(1, 0),
                      //                           end: Offset.zero)
                      //                       .animate(animation),
                      //                   child: child,
                      //                 );
                      //               },
                      //             ),
                      //           );
                      //         },
                      //         leading: Container(
                      //           height: 50,
                      //           width: 50,
                      //           decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: NetworkImage(seller[index]
                      //                         .userImage
                      //                         .contains('http')
                      //                     ? 'https://api.minimalavatars.com/avatar/random/png'
                      //                     : seller[index].userImage)
                      //                 // image: NetworkImage(
                      //                 //     "http://52.67.149.51/uploads/${seller!.data[0].userImage}"),
                      //                 ),
                      //           ),
                      //         ),
                      //         title: Text(seller[index].userName),
                      //         subtitle: Column(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: const [
                      //             Text("Click to see the message",
                      //                 style: TextStyle(color: Colors.grey)),
                      //             // Text(
                      //             //   "Hi, I am looking for a new house in the south of the city",
                      //             //   style: TextStyle(fontSize: 12),
                      //             // ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     const Divider(
                      //       color: Colors.grey,
                      //     )
                      //   ],
                      // );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              );
            }
          }),
    );
  }
}
