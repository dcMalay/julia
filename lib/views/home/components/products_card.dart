import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/product_model.dart';
import 'package:julia/data/repository/best_recommended_products_repo.dart';
import 'package:julia/views/home/products_details_screen.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Product>> productsData;

  @override
  void initState() {
    super.initState();
    setState(() {
      productsData = getProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1150,
      child: FutureBuilder<List<Product>>(
          future: productsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product>? data = snapshot.data;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 4.7,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    var currentItem = data[index];
                    var str = data[index].postDate.toString();
                    var parts = str.split('T');
                    var prefix = parts[1].trim();
                    var time = prefix.split('.');
                    var timepre = time[0].trim();
                    var isFeatured = currentItem.postFeatured;
                    var postStatus = currentItem.postStatus;

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
                            imageUrl:
                                "http://52.67.149.51/uploads/${currentItem.postImage![0]}",
                            time: timepre,
                            title: currentItem.postTitle!,
                            location: currentItem.postLocation.toString(),
                            price: currentItem.postPrice.toString(),
                            postStatus: postStatus!,
                            isfeatured: isFeatured,
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              );
            }
          }),
    );
  }
}

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard(
      {Key? key,
      required this.imageUrl,
      required this.time,
      required this.title,
      required this.location,
      required this.price,
      required this.postStatus,
      this.isfeatured})
      : super(key: key);
  final String imageUrl;
  final String time;
  final String title;
  final String location;
  final String price;
  int? isfeatured;
  final String postStatus;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    //print("Image ------>${widget.imageUrl}");
    super.initState();
  }

  var isFav = false;

  @override
  Widget build(BuildContext context) {
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
                  widget.imageUrl,
                  height: 100,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.time,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                    width: 60,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: widget.postStatus == 1.toString()
                        ? const Center(
                            child: Text(
                              'available',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'unavailable',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                  ),
                ],
              ),
              Text(
                widget.title,
                softWrap: true,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "SRD ${widget.price}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                      icon: isFav
                          ? Icon(
                              Icons.favorite,
                              color: redColor,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: redColor,
                            ))
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
                    widget.location,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        widget.isfeatured == 1
            ? Positioned(
                child: Container(
                    height: 20,
                    width: 50,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
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
                    )),
              )
            : Container()
      ],
    );
  }
}
