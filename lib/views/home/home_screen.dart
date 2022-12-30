import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/repository/products_repo.dart';
import 'package:julia/views/addtowishlist/wishlist_products_screen.dart';
import 'package:julia/views/explore/category_screen.dart';
import 'package:julia/views/home/components/category.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/notification/notification_screen.dart';
import 'package:julia/views/search/search_screen.dart';
import '../../data/model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isgetNotification = false;
  var productNo = 1;
  bool isHasMoreData = false;
  @override
  void initState() {
    productsData = getProduct(offset.toString());
    FirebaseMessaging.instance.getToken().then((value) {});
    productsData.then((value) {
      setState(() {
        productNo = (value.length / 2).ceil();
      });
    });
    super.initState();
  }

  late Future<List<Product>> productsData;
  int offset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: greenColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Julia',
              style: TextStyle(
                color: yellowColor,
                fontSize: 25,
              ),
            ),
            Text(
              'buy_or_sell'.tr(),
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
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
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: 'find_vehicles_furniture'.tr(),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'what_are_you_looking_for'.tr(),
                  style: const TextStyle(
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
                      "see_all".tr(),
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
            Text(
              'best_recommendation'.tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Products(
              productsDataoffset: productsData,
              productsNo: productNo,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 78.0),
              child: CupertinoButton(
                  color: greenColor,
                  child: const Text('load more'),
                  onPressed: () {
                    isHasMoreData
                        ? setState(() {
                            offset = offset + 10;
                          })
                        : setState(() {
                            offset = 0;
                          });
                    productsData = getProduct(offset.toString()).then((value) {
                      print(value.length);
                      value.length == 0
                          ? setState(() {
                              isHasMoreData = true;
                            })
                          : null;
                      print(isHasMoreData);
                      return value;
                    });
                    print('   offset--->$offset');
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
