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
      width: MediaQuery.of(context).size.width * 2 / 3,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 9,
            color: Color.fromARGB(255, 212, 212, 212),
          )
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 219, 219, 219),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.network(
                  'https://julia.primeshaun.in/uploads/62fd8be266c0bc3aafe3773592978d98994c9703.jpg'),
              title: const Text('One Plus 8'),
              subtitle: const Text('19 Sep 2022 - 06:00 PM'),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const Text(
              'Price',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            const Text(
              '\$ 35000',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Status',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            const Text(
              'Pending',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.analytics,
                        size: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'View 10',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite_sharp,
                        size: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'View 10',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete_outline,
                        size: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Remove',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
