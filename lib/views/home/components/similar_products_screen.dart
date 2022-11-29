import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/product_search_bysubcategoty.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/home/products_details_screen.dart';

class SimilarProductsScreen extends StatefulWidget {
  const SimilarProductsScreen({super.key, required this.subcategoryId});
  final String subcategoryId;
  @override
  State<SimilarProductsScreen> createState() => _SimilarProductsScreenState();
}

class _SimilarProductsScreenState extends State<SimilarProductsScreen> {
  late Future<List<Product>> subcategorywiseData;
  @override
  void initState() {
    super.initState();
    subcategorywiseData = getproductBySubcategory(widget.subcategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: FutureBuilder<List<Product>>(
            future: subcategorywiseData,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: greenColor,
                ));
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('NO product in this category'),
                );
              } else if (snapshot.hasData) {
                List<Product>? data = snapshot.data;
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var currentItem = data[index];
                      var str = data[index].postDate.toString();
                      var parts = str.split('T');
                      var prefix = parts[1].trim();
                      var time = prefix.split('.');
                      var timepre = time[0].trim();

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProductDetailsScreen(
                                  productID: currentItem.sId!,
                                );
                              }));
                            },
                            child: snapshot.data!.isEmpty
                                ? const Center(
                                    child: Text(
                                    "no data found",
                                    style: TextStyle(color: Colors.black),
                                  ))
                                : ProductCard(
                                    imageUrl: currentItem.postImage![0],
                                    time: timepre,
                                    title: currentItem.postTitle!,
                                    location: currentItem.postLocation
                                                .toString() ==
                                            "6353d8ede596901482a5b1e0"
                                        ? 'Brokopondo'
                                        : currentItem.postLocation.toString() ==
                                                '6353d8fce596901482a5b1e4'
                                            ? 'Commewijne'
                                            : currentItem.postLocation
                                                        .toString() ==
                                                    '6353d90fe596901482a5b1e8'
                                                ? 'Coronie'
                                                : currentItem.postLocation
                                                            .toString() ==
                                                        '6353d923e596901482a5b1ed'
                                                    ? 'Marowijne'
                                                    : currentItem.postLocation
                                                                .toString() ==
                                                            '6353d934e596901482a5b1ef'
                                                        ? 'Nickerie'
                                                        : currentItem
                                                                    .postLocation
                                                                    .toString() ==
                                                                '6353e63ee596901482a5b1f7'
                                                            ? 'Para'
                                                            : currentItem
                                                                        .postLocation
                                                                        .toString() ==
                                                                    '6353e647e596901482a5b1fb'
                                                                ? 'Paramaribo'
                                                                : currentItem
                                                                            .postLocation
                                                                            .toString() ==
                                                                        '6353e650e596901482a5b1fd'
                                                                    ? "Saramacca"
                                                                    : currentItem.postLocation.toString() ==
                                                                            "6353e659e596901482a5b1ff"
                                                                        ? 'Sipaliwini'
                                                                        : currentItem.postLocation.toString() ==
                                                                                '6353e663e596901482a5b201'
                                                                            ? 'Wanica'
                                                                            : "no location",
                                    price: currentItem.postPrice!.toDouble(),
                                    postStatus: currentItem.postStatus!,
                                    productId: currentItem.sId!,
                                  ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error occur"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No Product available in this Category'));
              } else {
                return const Center(
                    child: Text('No Product available in this Category'));
              }
            }),
      ),
    );
  }
}
