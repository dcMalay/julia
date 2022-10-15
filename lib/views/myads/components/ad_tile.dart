import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdTile extends StatefulWidget {
  const AdTile({super.key});

  @override
  State<AdTile> createState() => _AdTileState();
}

class _AdTileState extends State<AdTile> {
  @override
  Widget build(BuildContext context) {
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
              leading: Image.network(
                  'https://julia.primeshaun.in/uploads/62fd8be266c0bc3aafe3773592978d98994c9703.jpg'),
              title: const Text('One Plus 8'),
              subtitle: const Text('19 Sep 2022 - 06:00 PM'),
              trailing: const Text(
                '\$18000',
                style: TextStyle(color: Colors.black),
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
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.green,
                      child: const Text(
                        'Get More Views',
                        style: TextStyle(fontSize: 11),
                      ),
                      onPressed: () {}),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 35,
                  width: 90,
                  child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.green,
                      child: const Text(
                        'Mark As Sold',
                        style: TextStyle(fontSize: 11),
                      ),
                      onPressed: () {}),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
