import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/all_category_model.dart';
import 'package:julia/data/repository/all_category_repo.dart';
import 'package:julia/views/explore/subcategory_screen.dart';

class CategoryscreenforSearch extends StatefulWidget {
  const CategoryscreenforSearch({Key? key}) : super(key: key);

  @override
  State<CategoryscreenforSearch> createState() =>
      _CategoryscreenforSearchState();
}

class _CategoryscreenforSearchState extends State<CategoryscreenforSearch> {
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

  @override
  void initState() {
    super.initState();
    setState(() {
      apidata = getAllCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      //using media query to override textScelefactor for all android devides because fontsize pixels are change according to device
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: greenColor,
            centerTitle: true,
            title: Text(
              'select_your_category_to_search'.tr(),
              style: const TextStyle(
                color: Colors.white,
              ),
            )),
        body: FutureBuilder<List<AllCategory>>(
          future: apidata,
          builder: (context, snapshot) {
            List<AllCategory>? data = snapshot.data;
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 140,
                    childAspectRatio: .1 / .11,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    var currentItem = data[index];
                    var cItem = categoryData[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
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
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              // reverseTransitionDuration: const Duration(seconds: 1),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SubCategoryScreenforSearch(
                                          categoryId: currentItem.id!),
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
                            cItem['imageUrl'] == null
                                ? Image.asset('')
                                : Image.asset(
                                    '${cItem['imageUrl']}',
                                    height: 35,
                                  ),
                            Text(
                              context.locale.toString() == 'nl'
                                  ? currentItem.postCategoryName!
                                  : categories[index],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: greenColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    // return Text(currentItem.postCategoryName!);
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
    );
  }
}
