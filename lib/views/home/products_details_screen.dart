import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'package:julia/data/repository/products_details_repo.dart';
import 'package:julia/views/addtowishlist/wishlist_products_screen.dart';
import 'package:julia/views/chat/chatting_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productID,
  });
  final String productID;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Future<List<ProductDetails>> productDetails;
  final _secureStorage = const FlutterSecureStorage();
  var authUser;
  getuser() async {
    authUser = await _secureStorage.read(key: "userId");
  }

  @override
  void initState() {
    super.initState();
    getuser();
    setState(() {
      productDetails = getProductDetails(widget.productID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Ads Details',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            InkWell(
              onTap: () {
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
              child: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            FutureBuilder<List<ProductDetails>>(
                future: productDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductDetails>? data = snapshot.data;
                    return InkWell(
                      onTap: () async {
                        final urlImage =
                            "https://julia.sr/uploads/${data![0].postImage[0]}";
                        final url = Uri.parse(urlImage);
                        final response = await http.get(url);
                        final bytes = response.bodyBytes;
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/image.jpg';
                        File(path).writeAsBytesSync(bytes);
                        await Share.shareXFiles([XFile(path)],
                            text:
                                'Title - ${data[0].postTitle} \n Price - SRD ${data[0].postPrice} \n Description - ${data[0].postDescription} \n https://julia.sr/product.php?post_id=${data[0].id}');
                      },
                      child: const Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: FutureBuilder<List<ProductDetails>>(
            future: productDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductDetails>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      var currentItem = data[index];
                      var str = data[index].postDate.toString();
                      var parts = str.split(' ');
                      var prefix = parts[1].trim();
                      var time = prefix.split('.');
                      var timepre = time[0].trim();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: currentItem.postImage.length,
                                itemBuilder: (context, index) {
                                  return currentItem.postImage.isEmpty
                                      ? Container(
                                          color: Colors.grey,
                                          height: 200,
                                          child: const Text('No Image Found'),
                                        )
                                      : Image.network(
                                          "https://julia.sr/uploads/${currentItem.postImage[index]}",
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 20.0, right: 10),
                            child: SizedBox(
                              height: 80,
                              child: Text(
                                currentItem.postTitle,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 10.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentItem.postCity,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                                Text(
                                  timepre,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 290,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.help_outline),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'About the Product',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          3.5 /
                                          5,
                                      height: 267,
                                      child: ListView(
                                        children: [
                                          Text(
                                            currentItem.postDescription,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Customer reviews',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: const [Text('4.2 out of 5')],
                            ),
                          )
                        ],
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
            }),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Column(
            children: [
              const Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: FutureBuilder<List<ProductDetails>>(
                    future: productDetails,
                    builder: (context, snapshot) {
                      List<ProductDetails>? data = snapshot.data;
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              var currentItem = data[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "SRD ${data[index].postPrice}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    currentItem.postUserId == authUser
                                        ? Container()
                                        : CupertinoButton(
                                            color: greenColor,
                                            child: const Text(
                                              'Chat',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  // reverseTransitionDuration: const Duration(seconds: 1),
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      ChattingScreen(
                                                    sellerprofileImage:
                                                        currentItem
                                                            .postImage[0],
                                                    sellerName:
                                                        currentItem.authName,
                                                    sellerId:
                                                        currentItem.postUserId,
                                                  ),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    return SlideTransition(
                                                      position: Tween<Offset>(
                                                              begin:
                                                                  const Offset(
                                                                      1, 0),
                                                              end: Offset.zero)
                                                          .animate(animation),
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          )
                                  ],
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
