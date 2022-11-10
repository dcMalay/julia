import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/model/wishlist_model.dart';
import 'package:julia/data/repository/add_to_favorite_repo.dart';
import 'package:julia/data/repository/best_recommended_products_repo.dart';
import 'package:julia/views/home/products_details_screen.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Product>> productsData;

  @override
  void initState() {
    super.initState();

    setState(() {
      productsData = getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQueryData = MediaQuery.of(context);
    // final scale =
    //     mediaQueryData.textScaleFactor.clamp(0.80.toInt(), 0.90.toInt());
    return SizedBox(
      height: 1150,
      child: FutureBuilder<List<Product>>(
          future: productsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product>? data = snapshot.data;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4.5,
                    crossAxisSpacing: (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                        ? 4
                        : 2,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    var currentItem = data[index];
                    var str = data[index].postDate.toString();
                    var parts = str.split('T');
                    var prefix = parts[1].trim();
                    var time = prefix.split('.');
                    var timepre = time[0].trim();
                    var isFeatured = currentItem.postFeatured;
                    var postStatus = currentItem.postStatus;
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductDetailsScreen(
                            productID: currentItem.sId!,
                          );
                        }));
                      },
                      child: ProductCard(
                        imageUrl: currentItem.postImage!.isEmpty
                            ? ''
                            : "http://52.67.149.51/uploads/${currentItem.postImage![0]}",
                        time: timepre,
                        title: currentItem.postTitle!,
                        location: currentItem.postLocation.toString() ==
                                "6353d8ede596901482a5b1e0"
                            ? 'Brokopondo'
                            : currentItem.postLocation.toString() ==
                                    '6353d8fce596901482a5b1e4'
                                ? 'Commewijne'
                                : currentItem.postLocation.toString() ==
                                        '6353d90fe596901482a5b1e8'
                                    ? 'Coronie'
                                    : currentItem.postLocation.toString() ==
                                            '6353d923e596901482a5b1ed'
                                        ? 'Marowijne'
                                        : currentItem.postLocation.toString() ==
                                                '6353d934e596901482a5b1ef'
                                            ? 'Nickerie'
                                            : currentItem.postLocation
                                                        .toString() ==
                                                    '6353e63ee596901482a5b1f7'
                                                ? 'Para'
                                                : currentItem.postLocation
                                                            .toString() ==
                                                        '6353e647e596901482a5b1fb'
                                                    ? 'Paramaribo'
                                                    : currentItem.postLocation
                                                                .toString() ==
                                                            '6353e650e596901482a5b1fd'
                                                        ? "Saramacca"
                                                        : currentItem
                                                                    .postLocation
                                                                    .toString() ==
                                                                "6353e659e596901482a5b1ff"
                                                            ? 'Sipaliwini'
                                                            : currentItem
                                                                        .postLocation
                                                                        .toString() ==
                                                                    '6353e663e596901482a5b201'
                                                                ? 'Wanica'
                                                                : "no location",
                        price: currentItem.postPrice!,
                        postStatus: postStatus!,
                        isfeatured: isFeatured,
                        productId: currentItem.sId!,
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
    );
  }
}

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    required this.imageUrl,
    required this.time,
    required this.title,
    required this.location,
    required this.price,
    required this.postStatus,
    this.isfeatured,
    required this.productId,
    this.userId,
  }) : super(key: key);
  final String imageUrl;
  final String time;
  final String title;
  final String location;
  final num price;
  int? isfeatured;
  final String postStatus;
  final String productId;
  String? userId;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late Future<List<WishList>> inWishList;

  @override
  void initState() {
    inWishList = isInWishlist(widget.productId);
    //print("Image ------>${widget.imageUrl}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Stack(
        children: [
          Container(
            height: 450,
            width: 170,
            padding: const EdgeInsets.all(10),
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
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.imageUrl.isEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.grey,
                          height: 100,
                          width: 160,
                          child: const Center(child: Text('No Image Found')),
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.imageUrl,
                          height: 100,
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.time,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Container(
                      height: 20,
                      width: 60,
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 2),
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: widget.postStatus == 1.toString()
                          ? const Center(
                              child: Text('available',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  )),
                            )
                          : const Center(
                              child: Text(
                                'unavailable',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.title,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SRD ${widget.price.toString()}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder<List<WishList>>(
                        future: isInWishlist(widget.productId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<WishList>? data = snapshot.data;
                            return data![0].id != 0.toString()
                                ? IconButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      setState(() {
                                        removefromFavorite(data[0].id);
                                        inWishList =
                                            isInWishlist(widget.productId);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: redColor,
                                    ))
                                : InkWell(
                                    onTap: () {
                                      print('add to favotire');
                                      addtoFavorite(widget.productId);
                                      setState(() {
                                        inWishList =
                                            isInWishlist(widget.productId);
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: redColor,
                                    ),
                                  );
                          } else if (snapshot.hasError) {
                            // return Text("${snapshot.error}");
                            return IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                print('add to favotire');
                                addtoFavorite(widget.productId);
                                setState(() {
                                  inWishList = isInWishlist(widget.productId);
                                });
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                color: redColor,
                              ),
                            );
                          } else {
                            return Icon(
                              Icons.favorite_border,
                              color: redColor,
                            );
                            // return Center(
                            //   child: CircularProgressIndicator(
                            //     color: greenColor,
                            //   ),
                            // );
                          }
                        })
                  ],
                ),
                // const SizedBox(
                //   height: 3,
                // ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 12,
                      color: Colors.grey,
                    ),
                    Text(
                      widget.location,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          widget.isfeatured == 1
              ? Positioned(
                  child: Container(
                    height: 20,
                    width: 50,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    decoration: BoxDecoration(
                        color: yellowColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        'Featured',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
