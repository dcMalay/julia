import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/products_repo.dart';
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
    productsData = getProduct(0.toString());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final scale = mediaQueryData.textScaleFactor.clamp(0.80, 0.90);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              autofocus: true,
              controller: searchController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: 'find_vehicles_furniture'.tr(),
              ),
              onChanged: (value) {
                setState(() {
                  productsData = getSearchedProduct(value);
                });
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: FutureBuilder<List<Product>>(
              future: productsData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product>? data = snapshot.data;
                  return GridView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: data!.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
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

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                            : currentItem.postLocation
                                                        .toString() ==
                                                    '6353d923e596901482a5b1ed'
                                                ? 'Marowijne'
                                                : currentItem.postLocation
                                                            .toString() ==
                                                        '6353d934e596901482a5b1ef'
                                                    ? 'Nickerie'
                                                    : currentItem.postLocation
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
                                                                : currentItem
                                                                            .postLocation
                                                                            .toString() ==
                                                                        "6353e659e596901482a5b1ff"
                                                                    ? 'Sipaliwini'
                                                                    : currentItem.postLocation.toString() ==
                                                                            '6353e663e596901482a5b201'
                                                                        ? 'Wanica'
                                                                        : "no location",
                                price: currentItem.postPrice!,
                                postStatus: currentItem.postStatus!,
                                productId: currentItem.sId!,
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text("search_bar_is_empty".tr()));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
