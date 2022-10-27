import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/plans_model.dart';
import 'package:julia/data/repository/all_plans_repo.dart';
import 'package:http/http.dart' as http;

class BuyBusiness extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BuyBusiness({super.key});

  @override
  State<BuyBusiness> createState() => _BuyBusinessState();
}

class _BuyBusinessState extends State<BuyBusiness> {
  late Future<List<Plans>> planDetails;
  List<bool> checkValue = [false, false];
  var planId;
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  Future placeorder() async {
    var url = '$baseUrl/user/build/order';
    var authUser = await _secureStorage.read(key: 'user_id');
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          "user_id": authUser,
          "plan_id": "",
        }));
  }

  @override
  void initState() {
    super.initState();
    planDetails = getallPlans();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plans>>(
        future: planDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Plans>? data = snapshot.data;
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  var currentItem = data[index];
                  var diff = int.parse(data[index].regprice) -
                      int.parse(data[index].disprice);
                  var discount = 100 * diff / int.parse(data[index].regprice);
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
                    body: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  const BoxDecoration(color: Colors.green),
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
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 400,
                                width: 200,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  margin: const EdgeInsets.all(8),
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                              value: checkValue[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  checkValue[index] = value!;
                                                });
                                              }),
                                          Text(
                                            currentItem.postAvailable
                                                .toString(),
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
                                        'Valid for ${currentItem.duration} days',
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                    bottomNavigationBar: Container(
                      decoration:
                          const BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          offset: Offset(-1, -4),
                          spreadRadius: 0,
                          blurRadius: 5,
                          color: Colors.grey,
                        )
                      ]),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: CupertinoButton(
                        color: Colors.green,
                        onPressed: () {
                          checkValue[index] ? planId = data[index].id : null;
                        },
                        child: const Text('Get active your package'),
                      ),
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
        });
  }
}
