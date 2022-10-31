import 'package:flutter/material.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/product_search_bysubcategoty.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/home/products_details_screen.dart';

class SubcategorySearchScreen extends StatefulWidget {
  const SubcategorySearchScreen({super.key, required this.subcategoryId});
  final String subcategoryId;
  @override
  State<SubcategorySearchScreen> createState() =>
      _SubcategorySearchScreenState();
}

class _SubcategorySearchScreenState extends State<SubcategorySearchScreen> {
  late Future<List<Product>> subcategorywiseData;
  @override
  void initState() {
    super.initState();
    subcategorywiseData = getproductBySubcategory(widget.subcategoryId);
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
            'Subcategory wise Products',
            style: TextStyle(color: Colors.black),
          )),
      body: FutureBuilder<List<Product>>(
          future: subcategorywiseData,
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
