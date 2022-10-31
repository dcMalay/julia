import 'package:flutter/material.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/best_recommended_products_repo.dart';
import 'package:julia/data/repository/titlewise_products_search_repo.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/home/products_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  late Future<List<Product>> productsData;
  @override
  void initState() {
    super.initState();
    productsData = getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            autofocus: true,
            controller: searchController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Find Vehicles,Furniture and more ... ',
            ),
            onChanged: (value) {
              setState(() {
                productsData = getSearchedProduct(value);
              });
            },
          ),
        ),
      ),
      body: FutureBuilder<List<Product>>(
          future: productsData,
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
                            print(" post ID ------->${currentItem.sId}");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductDetailsScreen(
                                productID: currentItem.sId!,
                              );
                            }));
                          },
                          child: ProductCard(
                            // imageUrl:
                            //   'https://media.istockphoto.com/photos/stylish-blue-headphones-on-multi-colored-duo-tone-background-lighting-picture-id1175355990?k=20&m=1175355990&s=612x612&w=0&h=LX5kcpZKWyJQA_Kh5Ub9EwDNpGtAimGr2AePNQJPYxE=',
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
              return const Center(child: Text("search bar is empty"));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
