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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          "Notificatios",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<ProductDetails>>(
        future: notificationData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductDetails>? data = snapshot.data;
            var postStatus = data![0].postStatus;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetailsScreen(
                      productID: data[0].id,
                    );
                  }));
                },
                child: Card(
                  elevation: 8,
                  child: ListTile(
                    title: Text("Post title : ${data[0].postTitle}"),
                    trailing: postStatus == 0.toString()
                        ? const Text('Post Submitted')
                        : postStatus == 1.toString()
                            ? const Text("post approved")
                            : postStatus == 2.toString()
                                ? const Text('Post rejected')
                                : postStatus == 8.toString()
                                    ? const Text('Post deleted')
                                    : null,
                    subtitle: const Text('Post is live click to view product'),
                  ),
                ),
              ),
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
        },
      ),
    );
  }
}
