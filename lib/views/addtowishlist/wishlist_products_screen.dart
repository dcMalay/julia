import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/wishlist_product_model.dart';
import 'package:julia/data/repository/get_all_wish_list_products_repo.dart';
import 'package:julia/views/home/components/products_card.dart';
import '../home/products_details_screen.dart';

class WishListProductsScreen extends StatefulWidget {
  const WishListProductsScreen({super.key});

  @override
  State<WishListProductsScreen> createState() => _WishListProductsScreenState();
}

class _WishListProductsScreenState extends State<WishListProductsScreen> {
  late Future<WishListProduct> wishproductslist;

  @override
  void initState() {
    wishproductslist = getwishlistproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          centerTitle: true,
          title: Text(
            "wishlist".tr(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<WishListProduct>(
            future: wishproductslist,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: greenColor,
                ));
              } else if (snapshot.data!.products.isEmpty) {
                return Center(
                  child: Text('wishlist_is_empty'.tr()),
                );
              } else if (snapshot.hasData) {
                WishListProduct? data = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3.05 / 4.9,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: data!.products.length,
                      itemBuilder: (context, index) {
                        var str = data.products[index].postDate.toString();
                        var parts = str.split(' ');
                        var prefix = parts[1].trim();
                        var time = prefix.split('.');
                        var timepre = time[0].trim();
                        var currentItem = data.products[index];
                        print(timepre);

                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductDetailsScreen(
                                productID: currentItem.id,
                              );
                            }));
                          },
                          child: ProductCard(
                            imageUrl: currentItem.postImage.isEmpty
                                ? ''
                                : currentItem.postImage[0],
                            time: timepre,
                            title: currentItem.postTitle,
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
                                            : currentItem.postLocation
                                                        .toString() ==
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
                                                                : currentItem
                                                                            .postLocation
                                                                            .toString() ==
                                                                        '6353e663e596901482a5b201'
                                                                    ? 'Wanica'
                                                                    : "no location",
                            price: currentItem.postPrice,
                            postStatus: currentItem.postStatus,
                            productId: currentItem.id,
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text('failed_to_load'.tr());
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                );
              }
            }),
      ),
    );
  }
}
