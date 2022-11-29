import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julia/data/model/my_ads_model.dart';
import 'package:julia/data/repository/get_ads_status_repo.dart';
import 'package:julia/data/repository/my_ads_repo.dart';
import 'package:julia/views/myads/components/all_boost_screen.dart';
import '../../const/const.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  late Future<List<Myads>> getads;
  @override
  void initState() {
    super.initState();
    setState(() {
      getads = getAdsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: greenColor,
        centerTitle: true,
        title: const Text(
          'My Ads',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Myads>>(
          future: getads,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Myads> data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var currentItem = data[index];
                      //modifing date and time getting from response
                      var str = data[index].postDate.toString();
                      var parts = str.split(' ');
                      var date = parts[0].trim();
                      var prefix = parts[1].trim();
                      var time = prefix.split('.');
                      var timepre = time[0].trim();
                      var subcateogry = currentItem.postSubcategory;

                      return Container(
                        height: 150,
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 360,
                              height: 60,
                              child: ListTile(
                                leading:
                                    Image.network(currentItem.postImage[0]),
                                title: Text(
                                  currentItem.postTitle,
                                  maxLines: 2,
                                ),
                                subtitle: Text("$date  - $timepre"),
                                // const Text('19 Sep 2022 - 06:00 PM'),
                                trailing: Text(
                                  '\$ ${currentItem.postPrice}',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 35,
                                    width: 90,
                                    child: CupertinoButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        color: greenColor,
                                        child: const Text(
                                          'Get More Views',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(PageRouteBuilder(
                                            transitionDuration: const Duration(
                                                milliseconds: 500),
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                AllBoostScreen(
                                              subcategoryId: subcateogry,
                                              postId: currentItem.id,
                                            ),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return SlideTransition(
                                                position: Tween<Offset>(
                                                        begin:
                                                            const Offset(1, 0),
                                                        end: Offset.zero)
                                                    .animate(animation),
                                                child: child,
                                              );
                                            },
                                          ));
                                        }),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 35,
                                    width: 90,
                                    child: CupertinoButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        color:
                                            currentItem.postSold == 1.toString()
                                                ? Colors.grey
                                                : greenColor,
                                        child: Text(
                                          currentItem.postSold == 1.toString()
                                              ? "Repost"
                                              : 'Mark As Sold',
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                        onPressed: () {
                                          currentItem.postSold == 1.toString()
                                              ? changeAdStatus(currentItem.id)
                                              : getadStatus(currentItem.id);
                                          setState(() {
                                            getads = getAdsData();
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
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
