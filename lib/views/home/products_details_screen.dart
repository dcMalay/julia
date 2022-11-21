import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'package:julia/data/model/reting_model.dart';
import 'package:julia/data/repository/get_seller_rating_repo.dart';
import 'package:julia/data/repository/products_details_repo.dart';
import 'package:julia/data/repository/rate_seller_repo.dart';
import 'package:julia/views/addtowishlist/wishlist_products_screen.dart';
import 'package:julia/views/chat/chatting_screen.dart';
import 'package:julia/views/home/components/seller_review_details.dart';
import 'package:julia/views/reviews/reviews_screen.dart';
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
  late Future<List<RatingModel>> sellerRating;
  final _secureStorage = const FlutterSecureStorage();
  TextEditingController review = TextEditingController();
  TextEditingController starerating = TextEditingController();
  var authUser;
  getuser() async {
    authUser = await _secureStorage.read(key: "userId");
  }

  @override
  void initState() {
    super.initState();
    getuser();
    productDetails = getProductDetails(widget.productID).then((value) {
      sellerRating = getSellerRatingDetails(value[0].postUserId);
      return value;
    });

    //  productDetails = getProductDetails(widget.productID);
  }

  @override
  void dispose() {
    review.clear();
    starerating.clear();
    super.dispose();
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
                List<ProductDetails>? dataP = snapshot.data;
                return ListView.builder(
                    itemCount: dataP!.length,
                    itemBuilder: (context, index) {
                      var currentItem = dataP[index];
                      var str = dataP[index].postDate.toString();
                      var parts = str.split(' ');
                      var prefix = parts[1].trim();
                      var time = prefix.split('.');
                      var timepre = time[0].trim();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
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
                                      : Container(
                                          color: Colors.grey,
                                          child: Image.network(
                                            "https://julia.sr/uploads/${currentItem.postImage[index]}",
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                              'Seller Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 425,
                            child: FutureBuilder<List<RatingModel>>(
                                future: sellerRating,
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: greenColor,
                                    ));
                                  } else if (snapshot.data!.isEmpty) {
                                    return Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: SizedBox(
                                          height: 80,
                                          width: 500,
                                          child: SellerReviewSection(
                                            avgRating: 0.0,
                                            userId: dataP[index].postUserId,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Write a review for the seller'),
                                                  content: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Text(
                                                          'Give star out of 5'),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        controller: starerating,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: <
                                                            TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  "^(1[0-0]|[1-5])\$")),
                                                        ],
                                                        maxLength: 1,
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder()),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      const Text(
                                                        'Review',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextFormField(
                                                        controller: review,
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        minLines: 4,
                                                        maxLines: 9,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      CupertinoButton(
                                                          color: greenColor,
                                                          child: const Text(
                                                            'Submit',
                                                          ),
                                                          onPressed: () {
                                                            print('submit');
                                                            rateSeller(
                                                              dataP[index].id,
                                                              review.text,
                                                              dataP[index]
                                                                  .postUserId,
                                                              starerating.text,
                                                            );
                                                            setState(() {
                                                              productDetails =
                                                                  getProductDetails(
                                                                          widget
                                                                              .productID)
                                                                      .then(
                                                                          (value) {
                                                                sellerRating =
                                                                    getSellerRatingDetails(
                                                                        value[0]
                                                                            .postUserId);
                                                                return value;
                                                              });
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          })
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: const Center(
                                            child: Text(
                                              'rate the seller',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Center(
                                        child: Text('No reviews yet'),
                                      )
                                    ]);
                                  } else if (snapshot.hasData) {
                                    List<RatingModel>? data =
                                        snapshot.data!.reversed.toList();

                                    double avgRating = 0;
                                    double total = 0;
                                    //for average value of the star rating
                                    for (var i = 0; i < data.length; i++) {
                                      total = total + data[i].starRating!;
                                      avgRating = total / data.length;
                                    }
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: SizedBox(
                                            height: 80,
                                            width: 500,
                                            child: SellerReviewSection(
                                              avgRating: avgRating,
                                              userId: data[index].sellerId!,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Write a review for the seller'),
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                            'Give star out of 5'),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              starerating,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    "^(1[0-0]|[1-5])\$")),
                                                          ],
                                                          maxLength: 1,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder()),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Text(
                                                          'Review',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller: review,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          minLines: 4,
                                                          maxLines: 9,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        CupertinoButton(
                                                            color: greenColor,
                                                            child: const Text(
                                                              'Submit',
                                                            ),
                                                            onPressed: () {
                                                              rateSeller(
                                                                dataP[index].id,
                                                                review.text,
                                                                dataP[index]
                                                                    .postUserId,
                                                                starerating
                                                                    .text,
                                                              );
                                                              setState(() {
                                                                productDetails =
                                                                    getProductDetails(widget
                                                                            .productID)
                                                                        .then(
                                                                            (value) {
                                                                  sellerRating =
                                                                      getSellerRatingDetails(
                                                                          value[0]
                                                                              .postUserId);
                                                                  return value;
                                                                });
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            })
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: const Center(
                                              child: Text(
                                                'rate the seller',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text('Reviews'),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            AllReviewScreen(
                                                          postUserId: snapshot
                                                              .data![0]
                                                              .sellerId!,
                                                        ),
                                                        transitionsBuilder:
                                                            (context,
                                                                animation,
                                                                secondaryAnimation,
                                                                child) {
                                                          return SlideTransition(
                                                            position: Tween<
                                                                        Offset>(
                                                                    begin:
                                                                        const Offset(
                                                                            1,
                                                                            0),
                                                                    end: Offset
                                                                        .zero)
                                                                .animate(
                                                                    animation),
                                                            child: child,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'see all',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                var currentdata = data[index];
                                                var strRating = data[index]
                                                    .reviewTime
                                                    .toString();
                                                var partsR =
                                                    strRating.split(' ');
                                                var prefixR = partsR[0].trim();
                                                var timeR = prefixR.split('.');
                                                var timepreR = timeR[0].trim();

                                                return Card(
                                                  child: ListTile(
                                                    title: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(currentdata
                                                            .userName!),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '( $timepreR )',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 8),
                                                        )
                                                      ],
                                                    ),
                                                    subtitle: Text(
                                                        currentdata.review!),
                                                    trailing: SizedBox(
                                                      height: 60,
                                                      width: 60,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: yellowColor,
                                                          ),
                                                          Text(currentdata
                                                              .starRating
                                                              .toString())
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
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
