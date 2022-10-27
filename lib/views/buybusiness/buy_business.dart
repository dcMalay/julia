import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julia/data/model/plans_model.dart';
import 'package:julia/data/repository/all_plans_repo.dart';
import 'package:julia/views/buybusiness/components/buyad_tile.dart';

class BuyBusiness extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BuyBusiness({super.key});

  @override
  State<BuyBusiness> createState() => _BuyBusinessState();
}

class _BuyBusinessState extends State<BuyBusiness> {
  late Future<List<Plans>> planDetails;

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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Colors.green),
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
              const Center(
                child: SizedBox(
                  height: 400,
                  width: 200,
                  child: BuyAdTile(),
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
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            offset: Offset(-1, -4),
            spreadRadius: 0,
            blurRadius: 5,
            color: Colors.grey,
          )
        ]),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: CupertinoButton(
          color: Colors.green,
          onPressed: () {},
          child: const Text('Get active your package'),
        ),
      ),
    );
  }
}
