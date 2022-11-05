import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/wishlist_model.dart';
import 'package:julia/data/repository/add_to_favorite_repo.dart';
import 'package:julia/provider/is_in_wish_list_provider.dart';
import 'package:julia/provider/product_details_provider.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wishlistdata = Provider.of<IsInWishListProvider>(context);
    final productDetails = Provider.of<ProducrDetailsProvider>(context);
    print(wishlistdata.wishData.length);
    return wishlistdata.wishData.isEmpty
        ? Scaffold(
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
              title: const Text(
                "Wishlist",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: const Center(child: Text('wishlist is empty')),
          )
        : Scaffold(
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
              title: const Text(
                "Wishlist",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4.3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: productDetails.productDetails.length,
                  itemBuilder: (context, index) {
                    var str = productDetails.productDetails[index].postDate
                        .toString();
                    var parts = str.split(' ');
                    var prefix = parts[1].trim();
                    var time = prefix.split('.');
                    var timepre = time[0].trim();
                    return Stack(
                      children: [
                        Container(
                          height: 450,
                          width: 170,
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'http://52.67.149.51/uploads/${productDetails.productDetails[index].postImage[0]}',
                                  height: 100,
                                  width: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    timepre,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 60,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 2),
                                    decoration: BoxDecoration(
                                        color: greenColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: productDetails.productDetails[index]
                                                .postStatus ==
                                            1.toString()
                                        ? const Center(
                                            child: Text(
                                              'available',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          )
                                        : const Center(
                                            child: Text(
                                              'unavailable',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                              Text(
                                productDetails.productDetails[index].postTitle,
                                softWrap: true,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "SRD ${productDetails.productDetails[index].postPrice}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<List<WishList>>(
                                      future: isInWishlist(productDetails
                                          .productDetails[index].id),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<WishList>? data = snapshot.data;
                                          return data![index].id != 0.toString()
                                              ? IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  onPressed: () {
                                                    removefromFavorite(
                                                        data[0].id);
                                                    // setState(() {
                                                    //   inWishList = isInWishlist(
                                                    //        productDetails.id);
                                                    // });
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: redColor,
                                                  ))
                                              : IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  onPressed: () {
                                                    print('add to favotire');
                                                    addtoFavorite(productDetails
                                                        .productDetails[index]
                                                        .id);
                                                    // setState(() {
                                                    //   inWishList = isInWishlist(
                                                    //       widget.productId);
                                                    // });
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite_border,
                                                    color: redColor,
                                                  ),
                                                );
                                        } else if (snapshot.hasError) {
                                          // return Text("${snapshot.error}");
                                          return IconButton(
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () {
                                              print('add to favotire');
                                              addtoFavorite(productDetails
                                                  .productDetails[index].id);
                                              // setState(() {
                                              //   inWishList =
                                              //       isInWishlist(widget.productId);
                                              // });
                                            },
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: redColor,
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: greenColor,
                                            ),
                                          );
                                        }
                                      })
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    productDetails
                                        .productDetails[index].postLocation,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        productDetails.productDetails[index].postFeatured == 1
                            ? Positioned(
                                child: Container(
                                  height: 20,
                                  width: 50,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 2),
                                  decoration: BoxDecoration(
                                      color: yellowColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                    child: Text(
                                      'Featured',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    );
                  }),
            ),
          );
  }
}
