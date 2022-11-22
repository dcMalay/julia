import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/filter_by_location_category_repo.dart';
import 'package:julia/data/repository/filter_by_price_repo.dart';
import 'package:julia/data/repository/product_search_bycategory.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/home/products_details_screen.dart';
import '../../const/location_data.dart';

class CategorySearchScreen extends StatefulWidget {
  const CategorySearchScreen({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<CategorySearchScreen> createState() => _CategorySearchScreenState();
}

class _CategorySearchScreenState extends State<CategorySearchScreen> {
  late Future<List<Product>> filteredData;

  @override
  void initState() {
    super.initState();
    filteredData = getProductBycategory(widget.categoryId);
    //filteredData = filterbylocation('locationId', widget.categoryId);
    print('widget category ---->${widget.categoryId}');
  }

  @override
  Widget build(BuildContext context) {
    // final filterbyLocation = Provider.of<LocationFilterProvider>(context);
    // final filterbyPrice = Provider.of<PriceFilterProvider>(context);
    TextEditingController minvalController = TextEditingController();
    TextEditingController maxvalController = TextEditingController();
    print('refreshing page .........');
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: greenColor,
          title: const Text(
            "Category wise Products",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        context: context,
                        builder: (context) => SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 4 / 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 30.0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              size: 35,
                                            )),
                                        const Text(
                                          "Location",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: locationData.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                              onTap: () async {
                                                filteredData = filterbylocation(
                                                    '${locationData[index]["_id"]}',
                                                    widget.categoryId);

                                                // filteredData.then(
                                                //   (value) {
                                                //     print(value.length);
                                                //   },
                                                // );

                                                Timer(
                                                    const Duration(seconds: 2),
                                                    () {
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                });
                                              },
                                              title: Card(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 15,
                                                      horizontal: 8),
                                                  child: Text(
                                                      '${locationData[index]["location_name"]}'),
                                                ),
                                              ));
                                        }),
                                  ),
                                ],
                              ),
                            ));
                  },
                  child: const Icon(Icons.location_on_outlined)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * 4 / 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 30.0),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 35,
                                          )),
                                      const Text(
                                        "Choose Price",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 30.0, right: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the price';
                                      }
                                      return null;
                                    },
                                    controller: minvalController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'min val'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 30.0, right: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the price';
                                      }
                                      return null;
                                    },
                                    controller: maxvalController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Max val"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 30.0, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          color: greenColor,
                                          child: const Text('Clear Changes'),
                                          onPressed: () {
                                            minvalController.clear();
                                            maxvalController.clear();
                                          }),
                                      CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          color: greenColor,
                                          child: const Text('Apply Changes'),
                                          onPressed: () {
                                            // filterbyPrice
                                            //     .getpricefilteredProducts(
                                            //         widget.categoryId,
                                            //         minvalController.text,
                                            //         maxvalController.text);
                                            setState(() {
                                              filteredData =
                                                  filterProcuctsByPrice(
                                                widget.categoryId,
                                                int.parse(
                                                    minvalController.text),
                                                int.parse(
                                                    maxvalController.text),
                                              );
                                            });
                                            Timer(const Duration(seconds: 2),
                                                () {
                                              Navigator.pop(context);
                                            });
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                },
                child: const Icon(Icons.tune_outlined),
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Product>>(
            future: filteredData,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: greenColor,
                ));
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Products found in this category'),
                );
              } else if (snapshot.hasData) {
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
                                    imageUrl: currentItem.postImage!.isEmpty
                                        ? ""
                                        : "http://52.67.149.51/uploads/${currentItem.postImage![0]}",
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
                                    price: currentItem.postPrice!,
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
      ),
    );
  }
}
