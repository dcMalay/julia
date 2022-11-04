import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_details_model.dart';
import 'package:julia/views/home/components/products_card.dart';

class AddtoWishlistScreen extends StatefulWidget {
  const AddtoWishlistScreen({
    super.key,
    required this.productDetails,
  });

  final Future<List<ProductDetails>> productDetails;

  @override
  State<AddtoWishlistScreen> createState() => _AddtoWishlistScreenState();
}

class _AddtoWishlistScreenState extends State<AddtoWishlistScreen> {
  // var productId;
  // var wishlistLength = '';
  @override
  void initState() {
    // widget.inWishList.then((value) {
    //   setState(() {
    //     wishlistLength = value.length.toString();
    //   });
    // });

    // for (var i = 0; i < int.parse(wishlistLength); i++) {
    //   widget.productDetails.then((value) {
    //     setState(() {
    //       productId = value[i].id;
    //     });
    //   });
    // }

    super.initState();
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
        body: FutureBuilder<List<ProductDetails>>(
          future: widget.productDetails,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                  child: CircularProgressIndicator(
                color: greenColor,
              ));
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No Data found'),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4.3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var currentItem = snapshot.data![index];
                    var str = currentItem.postDate.toString();
                    var parts = str.split(' ');
                    var prefix = parts[1].trim();
                    var time = prefix.split('.');
                    var timepre = time[0].trim();
                    return ProductCard(
                      imageUrl:
                          "http://52.67.149.51/uploads/${currentItem.postImage[0]}",
                      time: timepre,
                      title: currentItem.postTitle,
                      location: currentItem.postLocation,
                      price: currentItem.postPrice.toString(),
                      postStatus: currentItem.postStatus,
                      productId: currentItem.id,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              );
            }
          },
        ));
  }
}
