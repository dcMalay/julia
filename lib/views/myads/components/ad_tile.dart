import 'package:flutter/material.dart';

class AdTile extends StatefulWidget {
  const AdTile({super.key});

  @override
  State<AdTile> createState() => _AdTileState();
}

class _AdTileState extends State<AdTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300,
          height: 60,
          child: ListTile(
            leading: Image.network(
                'https://julia.primeshaun.in/uploads/62fd8be266c0bc3aafe3773592978d98994c9703.jpg'),
            title: const Text('One Plus 8'),
            subtitle: const Text('19 Sep 2022 - 06:00 PM'),
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        const Expanded(
          child: Text(
            'Price',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Expanded(
          child: Text(
            '\$ 35000',
            style: TextStyle(color: Colors.black),
          ),
        ),
        const Expanded(
          child: Text(
            'Status',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        const Expanded(
          child: Text(
            'Pending',
            style: TextStyle(color: Colors.black),
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        Row(
          children: const [
            Expanded(
              child: ListTile(
                leading: Icon(Icons.analytics),
                title: Text('View 10'),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.favorite_sharp),
                title: Text('View 10'),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
