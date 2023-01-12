import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/model/wishlist_model.dart';
import 'package:julia/data/repository/add_to_favorite_repo.dart';
import 'package:julia/views/home/products_details_screen.dart';

class Products extends StatefulWidget {
  const Products({
    Key? key,
    required this.productsDataoffset,
    required this.productsNo,
  }) : super(key: key);
  final Future<List<Product>> productsDataoffset;
  final num productsNo;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 292.0 * widget.productsNo,
      child: FutureBuilder<List<Product>>(
          future: widget.productsDataoffset,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product>? data = snapshot.data;

              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3.05 / 4.9,
                    crossAxisSpacing: 10,
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
                            : currentItem.postImage![0],
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Stack(
        children: [
          Container(
            height: 450.h,
            width: 170.w,
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
                          height: 100.h,
                          width: 160.w,
                          child: const Center(child: Text('No Image Found')),
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.imageUrl,
                          height: 100.h,
                          width: 160.w,
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
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                    Container(
                      height: 20.h,
                      width: 60.w,
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 2),
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: widget.postStatus == 1.toString()
                          ? Center(
                              child: Text('available'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                  )),
                            )
                          : Center(
                              child: Text(
                                'unavailable'.tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.sp),
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
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 129.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          "SRD ${widget.price.toString()}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                          ),
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
                                  : IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        setState(() {
                                          addtoFavorite(widget.productId);
                                          inWishList =
                                              isInWishlist(widget.productId);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: redColor,
                                      ));
                            } else if (snapshot.hasError) {
                              return IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
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
                            }
                          })
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 12.sp,
                      color: Colors.grey,
                    ),
                    Text(
                      widget.location,
                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          widget.isfeatured == 1
              ? Positioned(
                  child: Container(
                    height: 20.h,
                    width: 50.w,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    decoration: BoxDecoration(
                        color: yellowColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'feature'.tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.sp,
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
