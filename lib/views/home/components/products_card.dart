import 'package:flutter/material.dart';
import 'package:julia/query/get_product.dart';
import 'package:julia/query/product_model.dart';

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
      height: 1000,
      child: FutureBuilder<List<Product>>(
          future: productsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product>? data = snapshot.data;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) {
                    var currentItem = data![index];
                    var str = data[index].postDate.toString();
                    var parts = str.split('T');
                    var prefix = parts[1].trim();
                    var time = prefix.split('.');
                    var timepre = time[0].trim();

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
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
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.time,
    required this.title,
    required this.location,
    required this.price,
  }) : super(key: key);
  final String imageUrl;
  final String time;
  final String title;
  final String location;
  final String price;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    print("Image ------>${widget.imageUrl}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
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
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: widget.imageUrl != []
                ? Image.network(
                    widget.imageUrl,
                    height: 100,
                    width: 160,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg',
                    height: 100,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.time,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
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
          const SizedBox(
            height: 5,
          ),
          Text(
            "€${widget.price}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
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
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
