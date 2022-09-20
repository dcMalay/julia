import 'package:flutter/material.dart';

final List<Map<String, String>> productData = [
  {
    'imageUrl': 'assets/camera.png',
    'time': "10 min ago",
    'title': "Apple Iphone 14 pro",
    'location': 'Bengaluru,SaltLake',
    'price': '\$8900',
  },
  {
    'imageUrl': 'assets/car1.webp',
    'time': "10 min ago",
    'title': "Apple Iphone 14 pro",
    'location': 'Bengaluru,SaltLake',
    'price': '\$8900',
  },
  {
    'imageUrl':
        'https://images.indianexpress.com/2022/09/iPhone-14-Pro-iPhone-14-Pro-Max-1.jpg',
    'time': "10 min ago",
    'title': "Apple Iphone 14 pro",
    'location': 'Bengaluru,SaltLake',
    'price': '\$8900',
  },
  {
    'imageUrl':
        'https://images.indianexpress.com/2022/09/iPhone-14-Pro-iPhone-14-Pro-Max-1.jpg',
    'time': "10 min ago",
    'title': "Apple Iphone 14 pro",
    'location': 'Bengaluru,SaltLake',
    'price': '\$8900',
  },
  {
    'imageUrl':
        'https://images.indianexpress.com/2022/09/iPhone-14-Pro-iPhone-14-Pro-Max-1.jpg',
    'time': "10 min ago",
    'title': "Apple Iphone 14 pro",
    'location': 'Bengaluru,SaltLake',
    'price': '\$8900',
  },
  {
    'imageUrl':
        'https://images.indianexpress.com/2022/09/iPhone-14-Pro-iPhone-14-Pro-Max-1.jpg',
    'time': "10 min ago",
    'title': "Apple Iphone 14 pro",
    'location': 'Bengaluru,SaltLake',
    'price': '\$8900',
  },
];

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: 300,
      child: GridView.builder(
          itemCount: productData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            var currentItem = productData[index];
            return ProductCard(
              imageUrl: "${currentItem['imageUrl']}",
              time: "${currentItem['time']}",
              title: "${currentItem['title']}",
              location: "${currentItem['location']}",
              price: "${currentItem['price']}",
            );
          }),
    );
  }
}

class ProductCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 314,
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
              Container(
                height: 190,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.grey,
                ),
                child: Image.network(imageUrl),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              Text(
                title,
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
                price,
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
                    location,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // Container(
        //   height: 314,
        //   width: 170,
        //   padding: const EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //         color: Colors.grey,
        //       ),
        //       color: Colors.white,
        //       boxShadow: const [
        //         BoxShadow(
        //           offset: Offset(4, 10),
        //           spreadRadius: -3,
        //           blurRadius: 5,
        //           color: Colors.grey,
        //         )
        //       ]),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //         height: 190,
        //         width: 160,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.grey,
        //         ),
        //         child: Image.network(imageUrl),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Text(
        //         time,
        //         style: const TextStyle(fontSize: 10, color: Colors.grey),
        //       ),
        //       Text(
        //         title,
        //         style: const TextStyle(
        //           fontSize: 20,
        //           color: Colors.black,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       Text(
        //         price,
        //         style: const TextStyle(
        //           fontSize: 20,
        //           color: Colors.black,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 15,
        //       ),
        //       Row(
        //         children: [
        //           const Icon(
        //             Icons.location_on_outlined,
        //             size: 12,
        //             color: Colors.grey,
        //           ),
        //           Text(
        //             location,
        //             style: const TextStyle(fontSize: 12, color: Colors.grey),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
