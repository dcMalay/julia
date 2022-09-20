import 'package:flutter/material.dart';
import 'package:julia/views/my_account/myads/components/ad_tile.dart';

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'My Ads',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: const [
            AdTile(),
            SizedBox(
              height: 10,
            ),
            AdTile(),
            SizedBox(
              height: 10,
            ),
            AdTile(),
            SizedBox(
              height: 10,
            ),
            AdTile(),
            SizedBox(
              height: 10,
            ),
            AdTile(),
          ],
        ),
      ),
    );
  }
}
