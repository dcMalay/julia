import 'package:flutter/material.dart';

class BuyAdTile extends StatefulWidget {
  const BuyAdTile({super.key});

  @override
  State<BuyAdTile> createState() => _BuyAdTileState();
}

class _BuyAdTileState extends State<BuyAdTile> {
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
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
                  value: checkValue,
                  onChanged: (value) {
                    setState(() {
                      checkValue = value!;
                    });
                  }),
              const Text(
                '30 ADS',
                style: TextStyle(
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
          const Text(
            '\$ 90 SRD',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Text(
            '\$100 SRD',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Valid for 7 days',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
            child: const Text('10% off'),
          )
        ],
      ),
    );
  }
}
