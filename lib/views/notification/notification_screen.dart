import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'package:julia/data/repository/notification_repo.dart';
import 'package:julia/views/home/products_details_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<ProductDetails>> notificationData;

  @override
  void initState() {
    notificationData = getNotification();
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('FirebaseMessaging.instance.getInitialMessage');
      if (message != null) {
        print('New Notification');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: greenColor,
          centerTitle: true,
          title: const Text(
            "Notificatios",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<ProductDetails>>(
          future: notificationData,
          builder: (context, snapshot) {
            // if (snapshot.data!.isEmpty) {
            //   return const Center(child: Text('Notification is Empty'));
            if (snapshot.data == null) {
              return Center(
                  child: CircularProgressIndicator(
                color: greenColor,
              ));
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Notification is Empty'));
            } else if (snapshot.hasData) {
              List<ProductDetails>? data = snapshot.data;

              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    var postStatus = data[index].postStatus;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProductDetailsScreen(
                              productID: data[0].id,
                            );
                          }));
                        },
                        child: Card(
                          elevation: 8,
                          child: ListTile(
                            title: Text(
                              "Post title : ${data[0].postTitle}",
                              maxLines: 1,
                            ),
                            trailing: postStatus == 0.toString()
                                ? const Text('Post Submitted')
                                : postStatus == 1.toString()
                                    ? const Text("post approved")
                                    : postStatus == 2.toString()
                                        ? const Text('Post rejected')
                                        : postStatus == 8.toString()
                                            ? const Text('Post deleted')
                                            : null,
                            subtitle: const Text(
                                'Post is live click to view product'),
                          ),
                        ),
                      ),
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
          },
        ),
      ),
    );
  }
}
