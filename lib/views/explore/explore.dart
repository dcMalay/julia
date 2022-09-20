import 'package:flutter/material.dart';
import 'package:julia/views/post_products/post_products.dart';

class Explore extends StatelessWidget {
  Explore({Key? key}) : super(key: key);
  final List<Map<String, String>> categoryData = [
    {
      'Id': '1',
      'imageUrl': 'assets/category/Audio.png',
      'title': 'Audio',
    },
    {
      'Id': '2',
      'imageUrl': 'assets/category/Auto.png',
      'title': 'Auto',
    },
    {
      'Id': '3',
      'imageUrl': 'assets/category/Body.png',
      'title': 'Body',
    },
    {
      'Id': '4',
      'imageUrl': 'assets/category/Boot.png',
      'title': 'Boot',
    },
    {
      'Id': '5',
      'imageUrl': 'assets/category/Bouw en materialen.png',
      'title': 'Bouw en materialen',
    },
    {
      'Id': '6',
      'imageUrl': 'assets/category/Brommer_Motorfiets.png',
      'title': 'Brommer_Motorfiets',
    },
    {
      'Id': '7',
      'imageUrl': 'assets/category/Computers en Software.png',
      'title': 'Computers en Software',
    },
    {
      'Id': '8',
      'imageUrl': 'assets/category/Dagvers.png',
      'title': 'Dagvers',
    },
    {
      'Id': '9',
      'imageUrl': 'assets/category/Dieren.png',
      'title': 'Dieren',
    },
    {
      'Id': '10',
      'imageUrl': 'assets/category/Fietsen.png',
      'title': 'Fietsen',
    },
    {
      'Id': '11',
      'imageUrl': 'assets/category/Gratis.png',
      'title': 'Gratis',
    },
    {
      'Id': '12',
      'imageUrl': 'assets/category/Hobby en Vrije Tijd.png',
      'title': 'Hobby en Vrije Tijd',
    },
    {
      'Id': '13',
      'imageUrl': 'assets/category/Huis en Inrichting.png',
      'title': 'Audio',
    },
    {
      'Id': '14',
      'imageUrl': 'assets/category/Kantoorbenodigdheden.png',
      'title': 'Kantoorbenodigdheden',
    },
    {
      'Id': '15',
      'imageUrl': 'assets/category/Kinderen en Baby_s.png',
      'title': 'Kinderen en Baby_s',
    },
    {
      'Id': '16',
      'imageUrl': 'assets/category/Kleding Dames.png',
      'title': 'Kleding Dames',
    },
    {
      'Id': '17',
      'imageUrl': 'assets/category/Kleding Heren.png',
      'title': 'Kleding Heren',
    },
    {
      'Id': '18',
      'imageUrl': 'assets/category/Medisch.png',
      'title': 'Medisch',
    },
    {
      'Id': '19',
      'imageUrl': 'assets/category/Muziek.png',
      'title': 'Muziek',
    },
    {
      'Id': '20',
      'imageUrl': 'assets/category/Personeel.png',
      'title': 'Personeel',
    },
    {
      'Id': '21',
      'imageUrl': 'assets/category/Sieraden.png',
      'title': 'Sieraden',
    },
    {
      'Id': '22',
      'imageUrl': 'assets/category/Speelgoed.png',
      'title': 'Speelgoed',
    },
    {
      'Id': '23',
      'imageUrl': 'assets/category/Sport en Fitness.png',
      'title': 'Sport en Fitness',
    },
    {
      'Id': '24',
      'imageUrl': 'assets/category/Telecommunicatie.png',
      'title': 'Telecommunicatie',
    },
    {
      'Id': '25',
      'imageUrl': 'assets/category/Tickets.png',
      'title': 'Tickets',
    },
    {
      'Id': '26',
      'imageUrl': 'assets/category/Toerisme _ Vakantie.png',
      'title': 'Toerisme _ Vakantie',
    },
    {
      'Id': '27',
      'imageUrl': 'assets/category/tuin.png',
      'title': 'tuin',
    },
    {
      'Id': '28',
      'imageUrl': 'assets/category/Wasmachines.png',
      'title': 'Wasmachines',
    },
    {
      'Id': '29',
      'imageUrl': 'assets/category/Woningen en percelen.png',
      'title': 'Kleding Heren',
    },
    {
      'Id': '30',
      'imageUrl': 'assets/category/Woningen en percelen.png',
      'title': 'Kleding Heren',
    },
    {
      'Id': '31',
      'imageUrl': 'assets/category/Zakelijke goederen.png',
      'title': 'Kleding Heren',
    },
    {
      'Id': '32',
      'imageUrl': 'assets/category/Zwaarmateriaal.png',
      'title': 'Zwaarmateriaal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Category',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: categoryData.length,
          itemBuilder: (context, index) {
            var currentItem = categoryData[index];
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Image.asset('${currentItem['imageUrl']}'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('${currentItem['title']}'),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
