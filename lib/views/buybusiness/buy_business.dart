import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/mope_details_model.dart';
import 'package:julia/data/model/plans_model.dart';
import 'package:julia/data/repository/all_plans_repo.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class BuyBusiness extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BuyBusiness({super.key});

  @override
  State<BuyBusiness> createState() => _BuyBusinessState();
}

class _BuyBusinessState extends State<BuyBusiness> {
  late Future<List<Plans>> planDetails;
  List<bool> checkValue = [false, false];
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<bool> openUrl(String link) async {
    try {
      var url = Uri.parse(link);
      await launchUrl(url);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  // Future<bool> open(String url) async {
  //   try {
  //     await launch(
  //       url,
  //       enableJavaScript: true,
  //     );
  //     return true;
  //   } catch (e) {
  //     log(e.toString());
  //     return false;
  //   }
  // }

  Future placeorder(String planId) async {
    var url = '$baseUrl/user/build/order';
    var authUser = await _secureStorage.read(key: 'userId');
    print(planId);
    print(authUser);
    final response = await http
        .post(Uri.parse(url),
            headers: {
              'Content-type': 'application/json',
            },
            body: json.encode({
              "user_id": authUser,
              "plan_id": planId,
            }))
        .then((value) async {
      var res = json.decode(value.body);
      var payres = Mopedetails.fromJson(res);
      print(payres.data.url);
      openUrl(payres.data.url);
    }).catchError((error) => print(error));
  }

  @override
  void initState() {
    super.initState();
    planDetails = getallPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Buy Business Package',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<Plans>>(
          future: planDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Plans>? data = snapshot.data;
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: greenColor),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                'http://52.67.149.51/assets/images/tag.png',
                                height: 90,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Heavy Discount',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'POST MORE ADS AND AUTO BOOST',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '\u2022 Post more ads and ads get boosted to the top every few days',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '\u2022 Reach upto 4 times more buyers',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                var currentItem = data[index];
                                var diff = int.parse(data[index].regprice) -
                                    int.parse(data[index].disprice);
                                var discount = 100 *
                                    diff /
                                    int.parse(data[index].regprice);
                                var day = currentItem.duration / 86400000;
                                return Container(
                                  height: 100,
                                  width: 150,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(3, 6),
                                          spreadRadius: 0,
                                          blurRadius: 8,
                                          color: Colors.grey,
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${currentItem.planName} plan',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${currentItem.postAvailable.toString()} ADS",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Divider(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '\$ ${currentItem.disprice} SRD',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$ ${currentItem.regprice} SRD',
                                        style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Valid for ${day.toInt()} days',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 25),
                                        decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child:
                                            Text('${discount.toInt()} % off'),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 5),
                                          color: greenColor,
                                          child: const Text(
                                            'Get active \n your package',
                                            style: TextStyle(fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                          onPressed: () {
                                            print('${data[index].id}+ $index');
                                            placeorder(data[index].id);
                                          }),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
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
