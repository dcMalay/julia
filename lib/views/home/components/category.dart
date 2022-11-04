import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/all_category_model.dart';
import 'package:julia/data/repository/all_category_repo.dart';
import 'package:julia/views/explore/category_screen.dart';
import 'package:julia/views/explore/subcategory_screen.dart';
import 'package:julia/views/explore/subcategory_search_screen.dart';

// ignore: must_be_immutable
class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List imageurl = [
    'assets/motorcycle.png',
    // 'assets/category/Brommer_Motorfiets.png',
    'assets/category/Computers en Software.png',
    'assets/category/Kleding Dames.png',
    'assets/category/Kantoorbenodigdheden.png',
    'assets/category/Dieren.png',
    'assets/category/Telecommunicatie.png',
    'assets/category/Hobby en Vrije Tijd.png',
    'assets/category/Muziek.png',
    // 'https://mpng.subpng.com/20190706/pqh/kisspng-motorcycle-ducati-superquadro-engine-superbike-rac-5d20f325a63085.1396549115624404856807.jpg',
    // 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Arduino_ftdi_chip-1.jpg/800px-Arduino_ftdi_chip-1.jpg',
    // 'https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&w=400',
    // 'https://akm-img-a-in.tosshub.com/businesstoday/images/story/202010/jobs_660_130920052343_291020052310.jpg?size=948:533',
    // 'https://img.freepik.com/free-photo/lovely-pet-portrait-isolated_23-2149192357.jpg?size=626&ext=jpg',
    // 'https://images.unsplash.com/photo-1598327105666-5b89351aff97?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG1vYmlsZSUyMHBob25lfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    // 'https://image.shutterstock.com/image-photo/closeup-books-stacked-on-tablebeside-260nw-1088861939.jpg',
  ];

  List categories = const [
    'Brommer_Motorfiets',
    'Computers en Software',
    'Kleding Dames',
    'Kantoorbenodigdheden',
    'Dieren',
    'Telecommunicatie',
    'Hobby en Vrije Tijd',
    'Muziek',
  ];

  late Future<List<AllCategory>> categorydata;
  @override
  void initState() {
    super.initState();
    categorydata = getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AllCategory>>(
        future: categorydata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AllCategory>? data = snapshot.data;
            return SizedBox(
              height: 100,
              child: Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    var curentItem = data![index];
                    return CategoryIcons(
                      categoryTitle: curentItem.postCategoryName!,
                      image: imageurl[index],
                      categoryId: curentItem.id!,
                    );
                  },
                ),
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
        });
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
    return InkWell(
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
    );
  }
}
