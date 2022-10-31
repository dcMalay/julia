import 'package:flutter/material.dart';
import 'package:julia/views/home/components/category.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/post_products/all_category.dart';
import 'package:julia/views/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      'Bangalore',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down_sharp),
                  ],
                ),
                const Icon(
                  Icons.notifications_outlined,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Holo',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('Buy or Sell'),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SearchScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1, 0), end: Offset.zero)
                            .animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              readOnly: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Find Vehicles,Furniture and more ... '),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'What are you looking for?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Categories(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ))
              ],
            ),
            Category(),
            const Text(
              'Best Recommendations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Products(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
