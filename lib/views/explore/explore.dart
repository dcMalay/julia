import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/all_category_model.dart';
import 'package:julia/data/model/category_count_model.dart';
import 'package:julia/data/repository/all_category_repo.dart';
import 'package:julia/views/explore/category_search_screen.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() {
    return _ExploreState();
  }
}

class _ExploreState extends State<Explore> {
  final List<Map<String, String>> categoryData = [
    {
      'Id': '1',
      'imageUrl': 'assets/category/Audio.png',
    },
    {
      'Id': '2',
      'imageUrl': 'assets/category/Auto.png',
    },
    {
      'Id': '3',
      'imageUrl': 'assets/category/Body.png',
    },
    {
      'Id': '4',
      'imageUrl': 'assets/category/Boot.png',
    },
    {
      'Id': '5',
      'imageUrl': 'assets/category/Bouw en materialen.png',
    },
    {
      'Id': '6',
      'imageUrl': 'assets/category/Brommer_Motorfiets.png',
    },
    {
      'Id': '7',
      'imageUrl': 'assets/category/Computers en Software.png',
    },
    {
      'Id': '8',
      'imageUrl': 'assets/category/Dagvers.png',
    },
    {
      'Id': '9',
      'imageUrl': 'assets/category/Dieren.png',
    },
    {
      'Id': '10',
      'imageUrl': 'assets/category/Fietsen.png',
    },
    {
      'Id': '11',
      'imageUrl': 'assets/category/Gratis.png',
    },
    {
      'Id': '12',
      'imageUrl': 'assets/category/Hobby en Vrije Tijd.png',
    },
    {
      'Id': '13',
      'imageUrl': 'assets/category/Huis en Inrichting.png',
    },
    {
      'Id': '14',
      'imageUrl': 'assets/category/Kantoorbenodigdheden.png',
    },
    {
      'Id': '15',
      'imageUrl': 'assets/category/Kinderen en Baby_s.png',
    },
    {
      'Id': '16',
      'imageUrl': 'assets/category/Kleding Dames.png',
    },
    {
      'Id': '17',
      'imageUrl': 'assets/category/Kleding Heren.png',
    },
    {
      'Id': '18',
      'imageUrl': 'assets/category/Medisch.png',
    },
    {
      'Id': '19',
      'imageUrl': 'assets/category/Muziek.png',
    },
    {
      'Id': '20',
      'imageUrl': 'assets/category/Personeel.png',
    },
    {
      'Id': '21',
      'imageUrl': 'assets/category/Sieraden.png',
    },
    {
      'Id': '22',
      'imageUrl': 'assets/category/Speelgoed.png',
    },
    {
      'Id': '23',
      'imageUrl': 'assets/category/Sport en Fitness.png',
    },
    {
      'Id': '24',
      'imageUrl': 'assets/category/Telecommunicatie.png',
    },
    {
      'Id': '25',
      'imageUrl': 'assets/category/Tickets.png',
    },
    {
      'Id': '26',
      'imageUrl': 'assets/category/Toerisme _ Vakantie.png',
    },
    {
      'Id': '27',
      'imageUrl': 'assets/category/tuin.png',
    },
    {
      'Id': '28',
      'imageUrl': 'assets/category/Wasmachines.png',
    },
    {
      'Id': '29',
      'imageUrl': 'assets/category/Woningen en percelen.png',
    },
    {
      'Id': '30',
      'imageUrl': 'assets/category/Woningen en percelen.png',
    },
    {
      'Id': '31',
      'imageUrl': 'assets/category/Zakelijke goederen.png',
    },
    {
      'Id': '32',
      'imageUrl': 'assets/category/Zwaarmateriaal.png',
    },
  ];

  List categories = const [
    'Audio, Tv and Photo',
    'Auto',
    'Bodycare',
    'Boats and accessories',
    'Construction and materials',
    'Moped / Motorcycle',
    'Computers and Software',
    'Daily fresh',
    'Animals',
    'Bicycles',
    'Free',
    'Hobby and leisure',
    'Home Appliance',
    'Office equipment',
    "Children and Babies",
    'Clothing | Ladies',
    'Clothing | Men',
    'Medical',
    'Music and Instruments',
    'Personnel and Professionals',
    'Jewelry, Bags and luxury products',
    'Toys',
    'Sports and Fitness',
    'Telecommunications',
    'Tickets and Tickets',
    'Tourism & Vacation',
    'Garden and Patio',
    'Washing Machines, White Goods and Equipment',
    'Houses and plots',
    'Business Goods',
    'Heavy Equipment / Trucks',
    'Foods'
  ];
  late Future<List<AllCategory>> apidata;
  late Future<List<ProductsCountModel>> categorycountdata;

  @override
  void initState() {
    super.initState();

    setState(() {
      apidata = getAllCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    // var categorywisecountdata = Provider.of<GetProductsCountProvider>(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          centerTitle: true,
          title: Text(
            'category'.tr(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<AllCategory>>(
            future: apidata,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AllCategory>? data = snapshot.data;
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 130,
                      childAspectRatio: .1 / .1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      var titleData = data[index];
                      var currentItem = categoryData[index];

                      return Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(4, 8),
                                spreadRadius: -3,
                                blurRadius: 5,
                                color: Colors.grey,
                              )
                            ]),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CategorySearchScreen(
                                            categoryId: titleData.id!),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                            begin: const Offset(1, 0),
                                            end: Offset.zero)
                                        .animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              currentItem['imageUrl'] == null
                                  ? const Text(
                                      'no Image',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  : Image.asset(
                                      '${currentItem['imageUrl']}',
                                      height: 40,
                                    ),
                              Text(
                                context.locale.toString() == "nl"
                                    ? titleData.postCategoryName!
                                    : categories[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}





// CategorySearchScreen(
//                                           categoryId: titleData.id!),