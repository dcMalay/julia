import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController minvalController = TextEditingController();
    TextEditingController maxvalController = TextEditingController();

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
          title: Text(
            "category_wise_product_search".tr(),
            style: const TextStyle(
              color: Colors.white,
            ),
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
                        height: MediaQuery.of(context).size.height * 4 / 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 30.0),
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
                                  Text(
                                    "location".tr(),
                                    style: const TextStyle(
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

                                          Timer(const Duration(seconds: 2), () {
                                            setState(() {});
                                            Navigator.pop(context);
                                          });
                                        },
                                        title: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 8),
                                            child: Text(
                                                '${locationData[index]["location_name"]}'),
                                          ),
                                        ));
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
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
                                      Text(
                                        "choose_price".tr(),
                                        style: const TextStyle(
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
                                        return 'please_enter_the_price'.tr();
                                      }
                                      return null;
                                    },
                                    controller: minvalController,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: 'min_val'.tr()),
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
                                        return 'please_enter_the_price'.tr();
                                      }
                                      return null;
                                    },
                                    controller: maxvalController,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: "max_val".tr()),
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
                                          child: Text('clear_changes'.tr()),
                                          onPressed: () {
                                            minvalController.clear();
                                            maxvalController.clear();
                                          }),
                                      CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          color: greenColor,
                                          child: Text('apply_changes'.tr()),
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
                return Center(
                  child: Text('no_product_found'.tr()),
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProductDetailsScreen(
                                  productID: currentItem.sId!,
                                );
                              }));
                            },
                            child: snapshot.data == [{}]
                                ? Center(
                                    child: Text(
                                    "no_data_found".tr(),
                                    style: const TextStyle(color: Colors.black),
                                  ))
                                : ProductCard(
                                    imageUrl: currentItem.postImage!.isEmpty
                                        ? ""
                                        : currentItem.postImage![0],
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
                return Center(child: Text("error_occur".tr()));
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
