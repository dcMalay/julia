import 'package:flutter/material.dart';
import 'package:julia/views/post_products/all_category.dart';

// ignore: must_be_immutable
class Category extends StatelessWidget {
  Category({Key? key}) : super(key: key);
  List imageurl = [
    'assets/category/Brommer_Motorfiets.png',
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5, mainAxisSpacing: 5, crossAxisCount: 4),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryIcons(
              categoryTitle: categories[index],
              image: imageurl[index],
            );
          },
        ),
      ),
    );
  }
}

class CategoryIcons extends StatelessWidget {
  const CategoryIcons(
      {Key? key, required this.categoryTitle, required this.image})
      : super(key: key);
  final String categoryTitle;
  final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            // reverseTransitionDuration: const Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Categories(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              //final tween = Tween(begin: 0.0, end: 1.0);
              //final fadeAnimation = animation.drive(tween);
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
            backgroundColor: Colors.grey,
            child: Image.asset(
              image,
              height: 40,
              width: 40,
            ),
          ),
          Text(categoryTitle),
        ],
      ),
    );
  }
}
