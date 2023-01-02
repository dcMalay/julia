import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/repository/products_repo.dart';
import 'package:julia/views/addtowishlist/wishlist_products_screen.dart';
import 'package:julia/views/explore/category_screen.dart';
import 'package:julia/views/home/components/category.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/notification/notification_screen.dart';
import 'package:julia/views/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/product_model.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:julia/data/repository/get_user_details_repo.dart';

import '../../provider/auth_provider.dart';
import '../../provider/google_sign_in_provider.dart';
import '../my_account/components/new_user_edit_screen.dart';
import 'components/show_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var status;
  void isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  bool isgetNotification = false;
  var productNo = 1;
  bool isHasMoreData = false;
  late Future<Userdetails> getUserData;
  @override
  void initState() {
    productsData = getProduct(offset.toString());
    FirebaseMessaging.instance.getToken().then((value) {});
    productsData.then((value) {
      setState(() {
        productNo = (value.length / 2).ceil();
      });
    });
    getUserData = getUserDetails();
    isloggedIn();
    super.initState();
  }

  late Future<List<Product>> productsData;
  int offset = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return status == true
        ? Scaffold(
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const WishListProductsScreen(),
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
            body: FutureBuilder<Userdetails>(
                future: getUserData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: greenColor,
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    print("data---->${snapshot.data}");
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoButton(
                              color: greenColor,
                              child: Text("set_your_profile".tr()),
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const NewUserEditScreen(
                                    isHome: false,
                                  ),
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
                                ));
                              }),
                          TextButton(
                            onPressed: () {
                              authProvider.logout();
                              var provider = Provider.of<GoogleSignInProvider>(
                                  context,
                                  listen: false);
                              provider.logOut();

                              ///using phoenix to restart the app after log out
                              // ignore: use_build_context_synchronously
                              Phoenix.rebirth(context);
                            },
                            child: Container(
                              height: 30,
                              width: 70,
                              padding: const EdgeInsets.only(
                                top: 6,
                                left: 8,
                              ),
                              decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                "log_out".tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Padding(
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
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const SearchScreen(),
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
                              textAlign: TextAlign.start,
                              readOnly: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const CategoryscreenforSearch(),
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
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom:
                                        5, // Space between underline and text
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 78.0),
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
                                  productsData = getProduct(offset.toString())
                                      .then((value) {
                                    print(value.length);
                                    value.length == 0
                                        ? setState(() {
                                            isHasMoreData = true;
                                          })
                                        : null;
                                    print(isHasMoreData);
                                    return value;
                                  });
                                  print('offset--->$offset');
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
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
          )
        : Scaffold(
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const WishListProductsScreen(),
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
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SearchScreen(),
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
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const CategoryscreenforSearch(),
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
                          productsData =
                              getProduct(offset.toString()).then((value) {
                            print(value.length);
                            value.length == 0
                                ? setState(() {
                                    isHasMoreData = true;
                                  })
                                : null;
                            print(isHasMoreData);
                            return value;
                          });
                          print('offset--->$offset');
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
