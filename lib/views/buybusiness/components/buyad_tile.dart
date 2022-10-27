import 'package:flutter/material.dart';
import 'package:julia/data/model/plans_model.dart';
import 'package:julia/data/repository/all_plans_repo.dart';

class BuyAdTile extends StatefulWidget {
  const BuyAdTile({super.key});

  @override
  State<BuyAdTile> createState() => _BuyAdTileState();
}

class _BuyAdTileState extends State<BuyAdTile> {
  List<bool> checkValue = [false, false];
  late Future<List<Plans>> planDetails;

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
                  return Container(
                    height: 200,
                    width: 200,
                    margin: const EdgeInsets.all(8),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: checkValue[index],
                                onChanged: (value) {
                                  setState(() {
                                    checkValue[index] = value!;
                                  });
                                }),
                            Text(
                              currentItem.postAvailable.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                            decoration: TextDecoration.lineThrough,
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
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text('10% off'),
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
        });
  }
}
