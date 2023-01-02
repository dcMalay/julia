import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';

import '../products_details_screen.dart';
import 'products_card.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({
    Key? key,
    required this.productsNo,
    required this.productList,
  }) : super(key: key);

  final num productsNo;
  final List<Product> productList;

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late Future<List<Product>> listOfProducts;
  List<Product> productList = [];

  Future<List<Product>> getProductList(String offset) async {
    final res = await http.get(Uri.parse('$baseUrl/user/all/ads/$offset'));

    if (res.statusCode == 200) {
      print('offset====>$offset');
      List jsonResponse = json.decode(res.body);
      List<Product> productData = jsonResponse
          .map((dynamic item) => Product.fromJson(item))
          .fold<Map<String, Product>>({}, (map, element) {
            map.putIfAbsent(element.sId!, () => element);
            return map;
          })
          .values
          .toList();
      productList.addAll(productData);
      print(productData);
      return productList;

      // return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {
    super.initState();
    listOfProducts = getProductList(widget.productsNo.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 292.0 * widget.productsNo,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3.05 / 4.9,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              var currentItem = productList[index];
              var str = productList[index].postDate.toString();
              var parts = str.split('T');
              var prefix = parts[1].trim();
              var time = prefix.split('.');
              var timepre = time[0].trim();
              var isFeatured = currentItem.postFeatured;
              var postStatus = currentItem.postStatus;
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                                      : currentItem.postLocation.toString() ==
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
                                                  : currentItem.postLocation
                                                              .toString() ==
                                                          "6353e659e596901482a5b1ff"
                                                      ? 'Sipaliwini'
                                                      : currentItem.postLocation
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
            }));
  }
}
