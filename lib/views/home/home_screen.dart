import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/location_model.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'package:julia/data/model/wishlist_model.dart';
import 'package:julia/data/repository/add_to_favorite_repo.dart';
import 'package:julia/data/repository/get_location_repo.dart';
import 'package:julia/provider/is_in_wish_list_provider.dart';
import 'package:julia/provider/product_details_provider.dart';
import 'package:julia/views/addtowishlist/wishlist_products_screen.dart';
import 'package:julia/views/explore/category_screen.dart';
import 'package:julia/views/home/components/category.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/notification/notification_screen.dart';
import 'package:julia/views/search/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Location>> allLocation;
  late Future<List<ProductDetails>> productDetails;
  late Future<List<WishList>> inWishList;
  List wishProductId = [];
  @override
  void initState() {
    super.initState();
    allLocation = getLocation();
    getlocationJsonData();

    inWishList = getWishListProducts();
  }

  @override
  Widget build(BuildContext context) {
    final wishlistdata = Provider.of<IsInWishListProvider>(context);
    final pDetails = Provider.of<ProducrDetailsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Holo',
              style: TextStyle(
                color: yellowColor,
                fontSize: 25,
              ),
            ),
            const Text(
              'Buy or Sell',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                // wishlistdata.isInWishList();

                // pDetails.pDetais(wishlistdata.wishedProductIds[0]);

                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const WishListProductsScreen(),
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
              icon: const Icon(Icons.favorite)),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const NotificationScreen(),
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
            child: const Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: Icon(
                Icons.notifications_rounded,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
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
            SizedBox(
              child: TextFormField(
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
                textAlign: TextAlign.start,
                readOnly: true,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Find Vehicles,Furniture and more ... ',
                ),
              ),
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const CategoryscreenforSearch(),
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
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: 5, // Space between underline and text
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: greenColor,
                          width: 1.0, // Underline thickness
                        ),
                      ),
                    ),
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: greenColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Category(),
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
