import 'package:flutter/material.dart';
import 'package:julia/data/model/all_category_model.dart';
import 'package:julia/data/repository/all_category_repo.dart';
import 'package:julia/provider/category_provider.dart';
import 'package:julia/views/post_products/post_products.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // final List<Map<String, String>> categoryData = [
  //   {
  //     'Id': '1',
  //     'imageUrl': 'assets/category/Audio.png',
  //     'title': 'Audio',
  //   },
  //   {
  //     'Id': '2',
  //     'imageUrl': 'assets/category/Auto.png',
  //     'title': 'Auto',
  //   },
  //   {
  //     'Id': '3',
  //     'imageUrl': 'assets/category/Body.png',
  //     'title': 'Body',
  //   },
  //   {
  //     'Id': '4',
  //     'imageUrl': 'assets/category/Boot.png',
  //     'title': 'Boot',
  //   },
  //   {
  //     'Id': '5',
  //     'imageUrl': 'assets/category/Bouw en materialen.png',
  //     'title': 'Bouw en materialen',
  //   },
  //   {
  //     'Id': '6',
  //     'imageUrl': 'assets/category/Brommer_Motorfiets.png',
  //     'title': 'Brommer_Motorfiets',
  //   },
  //   {
  //     'Id': '7',
  //     'imageUrl': 'assets/category/Computers en Software.png',
  //     'title': 'Computers en Software',
  //   },
  //   {
  //     'Id': '8',
  //     'imageUrl': 'assets/category/Dagvers.png',
  //     'title': 'Dagvers',
  //   },
  //   {
  //     'Id': '9',
  //     'imageUrl': 'assets/category/Dieren.png',
  //     'title': 'Dieren',
  //   },
  //   {
  //     'Id': '10',
  //     'imageUrl': 'assets/category/Fietsen.png',
  //     'title': 'Fietsen',
  //   },
  //   {
  //     'Id': '11',
  //     'imageUrl': 'assets/category/Gratis.png',
  //     'title': 'Gratis',
  //   },
  //   {
  //     'Id': '12',
  //     'imageUrl': 'assets/category/Hobby en Vrije Tijd.png',
  //     'title': 'Hobby en Vrije Tijd',
  //   },
  //   {
  //     'Id': '13',
  //     'imageUrl': 'assets/category/Huis en Inrichting.png',
  //     'title': 'Audio',
  //   },
  //   {
  //     'Id': '14',
  //     'imageUrl': 'assets/category/Kantoorbenodigdheden.png',
  //     'title': 'Kantoorbenodigdheden',
  //   },
  //   {
  //     'Id': '15',
  //     'imageUrl': 'assets/category/Kinderen en Baby_s.png',
  //     'title': 'Kinderen en Baby_s',
  //   },
  //   {
  //     'Id': '16',
  //     'imageUrl': 'assets/category/Kleding Dames.png',
  //     'title': 'Kleding Dames',
  //   },
  //   {
  //     'Id': '17',
  //     'imageUrl': 'assets/category/Kleding Heren.png',
  //     'title': 'Kleding Heren',
  //   },
  //   {
  //     'Id': '18',
  //     'imageUrl': 'assets/category/Medisch.png',
  //     'title': 'Medisch',
  //   },
  //   {
  //     'Id': '19',
  //     'imageUrl': 'assets/category/Muziek.png',
  //     'title': 'Muziek',
  //   },
  //   {
  //     'Id': '20',
  //     'imageUrl': 'assets/category/Personeel.png',
  //     'title': 'Personeel',
  //   },
  //   {
  //     'Id': '21',
  //     'imageUrl': 'assets/category/Sieraden.png',
  //     'title': 'Sieraden',
  //   },
  //   {
  //     'Id': '22',
  //     'imageUrl': 'assets/category/Speelgoed.png',
  //     'title': 'Speelgoed',
  //   },
  //   {
  //     'Id': '23',
  //     'imageUrl': 'assets/category/Sport en Fitness.png',
  //     'title': 'Sport en Fitness',
  //   },
  //   {
  //     'Id': '24',
  //     'imageUrl': 'assets/category/Telecommunicatie.png',
  //     'title': 'Telecommunicatie',
  //   },
  //   {
  //     'Id': '25',
  //     'imageUrl': 'assets/category/Tickets.png',
  //     'title': 'Tickets',
  //   },
  //   {
  //     'Id': '26',
  //     'imageUrl': 'assets/category/Toerisme _ Vakantie.png',
  //     'title': 'Toerisme _ Vakantie',
  //   },
  //   {
  //     'Id': '27',
  //     'imageUrl': 'assets/category/tuin.png',
  //     'title': 'tuin',
  //   },
  //   {
  //     'Id': '28',
  //     'imageUrl': 'assets/category/Wasmachines.png',
  //     'title': 'Wasmachines',
  //   },
  //   {
  //     'Id': '29',
  //     'imageUrl': 'assets/category/Woningen en percelen.png',
  //     'title': 'Kleding Heren',
  //   },
  //   {
  //     'Id': '30',
  //     'imageUrl': 'assets/category/Woningen en percelen.png',
  //     'title': 'Kleding Heren',
  //   },
  //   {
  //     'Id': '31',
  //     'imageUrl': 'assets/category/Zakelijke goederen.png',
  //     'title': 'Kleding Heren',
  //   },
  //   {
  //     'Id': '32',
  //     'imageUrl': 'assets/category/Zwaarmateriaal.png',
  //     'title': 'Zwaarmateriaal',
  //   },
  // ];
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
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: FutureBuilder<List<AllCategory>>(
        future: apidata,
        builder: (context, snapshot) {
          List<AllCategory>? data = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  var currentItem = data[index];
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
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            // reverseTransitionDuration: const Duration(seconds: 1),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const PostProductsView(),
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
                      title: Text(currentItem.postCategoryName!),
                    ),
                  );
                  // return Text(currentItem.postCategoryName!);
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
        // body: FutureBuilder<List<AllCategory>>(
        //     future: categoryProvider.getCategory(),
        //     builder: (context, snapshot) {
        //       List<AllCategory>? data = snapshot.data;
        //       if (snapshot.hasData) {
        //         return Padding(
        //           padding: const EdgeInsets.all(8),
        //           child: ListView.builder(
        //             scrollDirection: Axis.vertical,
        //             itemCount: data!.length,
        //             itemBuilder: (context, index) {
        //               // var currentItem = categoryData[index];
        //               var currentItem = data[index];
        //               return InkWell(
        //                 onTap: () {
        //                   Navigator.of(context).push(
        //                     PageRouteBuilder(
        //                       transitionDuration:
        //                           const Duration(milliseconds: 500),
        //                       // reverseTransitionDuration: const Duration(seconds: 1),
        //                       pageBuilder:
        //                           (context, animation, secondaryAnimation) =>
        //                               const PostProductsView(),
        //                       transitionsBuilder: (context, animation,
        //                           secondaryAnimation, child) {
        //                         return SlideTransition(
        //                           position: Tween<Offset>(
        //                                   begin: const Offset(1, 0),
        //                                   end: Offset.zero)
        //                               .animate(animation),
        //                           child: child,
        //                         );
        //                       },
        //                     ),
        //                   );
        //                 },
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       // CircleAvatar(
        //                       //   backgroundColor: Colors.grey,
        //                       //   child: Image.asset('${currentItem['imageUrl']}'),
        //                       // ),
        //                       const SizedBox(
        //                         width: 20,
        //                       ),
        //                       Text(currentItem.postCategoryName),
        //                       const SizedBox(
        //                         width: 10,
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Text("${snapshot.error}");
        //       } else {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //     }),
      

