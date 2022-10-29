import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/all_boost_model.dart';
import 'package:julia/data/model/boost_mope_details_model.dart';
import 'package:julia/data/repository/all_boost_repo.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AllBoostScreen extends StatefulWidget {
  const AllBoostScreen(
      {super.key, required this.subcategoryId, required this.postId});
  final String subcategoryId;
  final String postId;
  @override
  State<AllBoostScreen> createState() => _AllBoostScreenState();
}

class _AllBoostScreenState extends State<AllBoostScreen> {
  late Future<List<AllBoost>> getboostData;
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<bool> openUrl(String link) async {
    try {
      var url = Uri.parse(link);
      await launchUrl(url);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // getboostData = getparticularboost(widget.subcategoryId);
      getboostData = getallboost();
    });
    print('postid------->${widget.postId}');
  }

  Future boostPost(String boostId, postId) async {
    var url = '$baseUrl/user/build/boost';
    var authUser = await _secureStorage.read(key: 'userId');
    print(boostId);
    print(authUser);
    var res = await http
        .post(Uri.parse(url),
            headers: {
              'Content-type': 'application/json',
            },
            body: json.encode({
              "user_id": authUser,
              "post_id": postId,
              "boost": boostId,
            }))
        .then((value) async {
      var res = json.decode(value.body);
      var payres = BoostMopeDetails.fromJson(res);
      print(payres.data.url);

      openUrl(payres.data.url);
    }).catchError((error) => print(error));
    print(res.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: const Text(
            'boost your post',
            style: TextStyle(color: Colors.black),
          )),
      body: FutureBuilder<List<AllBoost>>(
          future: getboostData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<AllBoost>? data = snapshot.data;
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    var currentItem = data[index];
                    var day = currentItem.boostDuration / 86400000;
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
                              leading: Text(
                                currentItem.boostTitle,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '\$ ${currentItem.boostDiscprice} SRD',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$ ${currentItem.boostRegprice} SRD',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              // const Text('19 Sep 2022 - 06:00 PM'),
                              trailing: Text(
                                'Valid for ${day.toInt()} days',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
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
                                      color: Colors.green,
                                      child: Text(
                                        'Buy for ${day.toInt()} day',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      onPressed: () {
                                        boostPost(
                                            currentItem.id, widget.postId);
                                      }),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
