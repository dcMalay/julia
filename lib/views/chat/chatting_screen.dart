import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/get_all_messages_model.dart';
import 'package:julia/data/repository/messages_repo.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key, required this.sellerName});
  final String sellerName;
  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  late Future<List<Allmessage>> allMessage;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  var user;
  void getuserid() async {
    var authUser = await _secureStorage.read(key: 'userId');
    setState(() {
      user = authUser;
    });
  }

  @override
  void initState() {
    super.initState();
    allMessage = getallMessages();
    getuserid();
  }

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
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                flex: 0,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(widget.sellerName),
                  subtitle: const Text('Seller'),
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<int>(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (context) => [
                // popupmenu item 1
                const PopupMenuItem(value: 1, child: Text("Delete Chat")),
                // popupmenu item 2
                const PopupMenuItem(value: 2, child: Text("Report User")),
                const PopupMenuItem(value: 3, child: Text("Block User")),
              ],
            ),
          ],
        ),
        body: FutureBuilder<List<Allmessage>>(
            future: allMessage,
            builder: (context, snapshot) {
              List<Allmessage>? data = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      var currentItem = data[index];
                      return Column(
                        children: [
                          Align(
                            alignment: currentItem.reciverId !=
                                    _secureStorage
                                        .read(key: 'userId')
                                        .toString()
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(currentItem.message),
                              ),
                            ),
                          )
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error occur"));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                );
              }
            }));
  }
}
