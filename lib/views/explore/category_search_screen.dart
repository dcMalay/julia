// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/product_search_bycategory.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/home/products_details_screen.dart';

class CategorySearchScreen extends StatefulWidget {
  const CategorySearchScreen({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<CategorySearchScreen> createState() => _CategorySearchScreenState();
}

class _CategorySearchScreenState extends State<CategorySearchScreen> {
  late Future<List<Product>> categorywiseData;
  @override
  void initState() {
    super.initState();
    categorywiseData = getProductBycategory(widget.categoryId);
    print(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Category wise Products",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<Product>>(
          future: categorywiseData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product>? data = snapshot.data;
              return GridView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 3,
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

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            print(snapshot.data);
                            print(" post ID ------->${currentItem.sId}");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductDetailsScreen(
                                productID: currentItem.sId!,
                              );
                            }));
                          },
                          child: snapshot.data == [{}]
                              ? const Center(
                                  child: Text(
                                  "no data found",
                                  style: TextStyle(color: Colors.black),
                                ))
                              : ProductCard(
                                  imageUrl:
                                      "http://52.67.149.51/uploads/${currentItem.postImage![0]}",
                                  time: timepre,
                                  title: currentItem.postTitle!,
                                  location: currentItem.postLocation.toString(),
                                  price: currentItem.postPrice.toString(),
                                  postStatus: currentItem.postStatus!,
                                  productId: currentItem.sId!,
                                ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error occur"));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
