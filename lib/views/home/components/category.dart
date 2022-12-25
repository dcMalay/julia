import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/all_category_model.dart';
import 'package:julia/data/repository/all_category_repo.dart';
import 'package:julia/views/explore/subcategory_screen.dart';

// ignore: must_be_immutable
class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List imageurl = [
    'assets/category/Audio.png',
    'assets/category/Auto.png',
    'assets/category/Body.png',
    'assets/category/Boot.png',
    'assets/category/Bouw en materialen.png',
    'assets/category/Brommer_Motorfiets.png',
    'assets/category/Computers en Software.png',
    "assets/category/Dagvers.png",
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
  ];

  late Future<List<AllCategory>> categorydata;
  @override
  void initState() {
    super.initState();
    categorydata = getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: FutureBuilder<List<AllCategory>>(
          future: categorydata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<AllCategory>? data = snapshot.data;
              return SizedBox(
                height: 100,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    var curentItem = data![index];
                    return CategoryIcons(
                      categoryTitle: context.locale.toString() == "nl"
                          ? curentItem.postCategoryName!
                          : categories[index],
                      image: imageurl[index],
                      categoryId: curentItem.id!,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              );
            }
          }),
    );
  }
}

class CategoryIcons extends StatelessWidget {
  const CategoryIcons(
      {Key? key,
      required this.categoryTitle,
      required this.image,
      required this.categoryId})
      : super(key: key);
  final String categoryTitle;
  final String image;
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SubCategoryScreenforSearch(categoryId: categoryId),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                          .animate(animation),
                  child: child,
                );
              },
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color.fromARGB(255, 236, 233, 233),
              child: Image.asset(
                image,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(
              width: 80,
              child: Text(
                categoryTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
