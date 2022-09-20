import 'package:flutter/material.dart';
import 'package:julia/views/home/components/category.dart';
import 'package:julia/views/home/components/products_card.dart';
import 'package:julia/views/home/products_details_screen.dart';
import 'package:julia/views/post_products/all_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      'Bangalore',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down_sharp),
                  ],
                ),
                const Icon(
                  Icons.notifications_outlined,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Holo',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('Buy or Sell'),
            const SizedBox(
              height: 15,
            ),
            const TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search_rounded),
                  hintText: 'Find Vehicles,Furniture and more ... '),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'What are you looking for?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          // reverseTransitionDuration: const Duration(seconds: 1),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Categories(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            //final tween = Tween(begin: 0.0, end: 1.0);
                            //final fadeAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ))
              ],
            ),
            Category(),
            const Text(
              'Best Recommendations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'Trucks',
                        productprice: '€ 50000',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/68a234d4d29065e0210e87c46f6ff6be2a1aec26.jpg',
                        location: 'Nickerie',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/68a234d4d29065e0210e87c46f6ff6be2a1aec26.jpg",
                    time: '10 mins ago',
                    title: 'Trucks',
                    location: 'Nickerie',
                    price: "€ 50000",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'Car seat cover',
                        productprice: '€ 500',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/3c0cca291d9528d638a903efc70225376a67320e.jpg',
                        location: 'Paramaribo',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/3c0cca291d9528d638a903efc70225376a67320e.jpg",
                    time: '10 mins ago',
                    title: 'Car seat cover',
                    location: 'Paramaribo',
                    price: "€ 500",
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName:
                            'eAirtec 109 cms (43 inches) Full HD Smart LED TV with Voice Remote Control 43ATDJ (2022 Model)',
                        productprice: '€ 2000',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/62fd8be266c0bc3aafe3773592978d98994c9703.jpg',
                        location: 'Nickerie',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/62fd8be266c0bc3aafe3773592978d98994c9703.jpg",
                    time: '10 mins ago',
                    title:
                        'eAirtec 109 cms (43 inches) Full HD Smart LED TV with Voice Remote Control 43ATDJ (2022 Model)',
                    location: 'Nickerie',
                    price: "€ 2000",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'Air Bags',
                        productprice: '€ 300',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/3215947cf094d90f922b038e2d29f12ee979bb05.jpg',
                        location: 'Marowijne',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/3215947cf094d90f922b038e2d29f12ee979bb05.jpg",
                    time: '10 mins ago',
                    title: 'Air Bags',
                    location: 'Marowijne',
                    price: "€ 300",
                  ),
                ),
              ],
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'Modern Office Furniture',
                        productprice: '€ 30',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/d516c1879dc73141cfdf1253263795d83cc5eeef.jpg',
                        location: 'Sipaliwini',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/d516c1879dc73141cfdf1253263795d83cc5eeef.jpg",
                    time: '10 mins ago',
                    title: 'Modern Office Furniture',
                    location: 'Sipaliwini',
                    price: "€ 30",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName:
                            'ARCTIC AR-PVK-01 Neo Violin Kit - Violin 4/4 with case, bow',
                        productprice: '€ 100',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/0c6faa3de44975fbf0f8442c8c2f2075465b0470.jpg',
                        location: 'Coronie',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/0c6faa3de44975fbf0f8442c8c2f2075465b0470.jpg",
                    time: '10 mins ago',
                    title:
                        'ARCTIC AR-PVK-01 Neo Violin Kit - Violin 4/4 with case, bow',
                    location: 'Coronie',
                    price: "€ 100",
                  ),
                ),
              ],
            ),
            //row 3
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'Rolls Royace',
                        productprice: '€ 4000000',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/1a41a71bf8126c475caec935a363d452fb5816d0.jpg',
                        location: 'Nickerie',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/1a41a71bf8126c475caec935a363d452fb5816d0.jpg",
                    time: '10 mins ago',
                    title: 'Rolls Royace',
                    location: 'Nickerie',
                    price: "€ 4000000",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'Royal Enfield',
                        productprice: '€ 80000',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/166e5a0b1ddbdf376c1464cd79f5d9cd0f81c34a.jpg',
                        location: 'Para',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/166e5a0b1ddbdf376c1464cd79f5d9cd0f81c34a.jpg",
                    time: '10 mins ago',
                    title: 'Royal Enfield',
                    location: 'Para',
                    price: "€ 80000",
                  ),
                ),
              ],
            ),
            //row 4
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'APPLE iPhone 11 (White, 64 GB)',
                        productprice: '€ 40000',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/ec3d9908f23a4f54943c9bf583a8ff691ea98366.jpg',
                        location: 'Saramacca',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/ec3d9908f23a4f54943c9bf583a8ff691ea98366.jpg",
                    time: '10 mins ago',
                    title: 'APPLE iPhone 11 (White, 64 GB)',
                    location: 'Saramacca',
                    price: "€ 40000",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName: 'Plant trees, cleaning gardens',
                        productprice: '€ 20',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/1b21ebf473b1133eb7d62211991f87043a270176.jpg',
                        location: 'Nickerie',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/1b21ebf473b1133eb7d62211991f87043a270176.jpg",
                    time: '10 mins ago',
                    title: 'Plant trees, cleaning gardens',
                    location: 'Nickerie',
                    price: "€ 20",
                  ),
                ),
              ],
            ),
            //row5
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName:
                            'Reformation Isaac gathered organic cotton-blend poplin maxi dress',
                        productprice: '€280',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/cd3c3db37915e99ec30aa81a55bfeaa4264ea654.jpg',
                        location: 'Marowijne',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/cd3c3db37915e99ec30aa81a55bfeaa4264ea654.jpg",
                    time: '10 mins ago',
                    title:
                        'Reformation Isaac gathered organic cotton-blend poplin maxi dress',
                    location: 'Marowijne',
                    price: "€280",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ProductDetailsScreen(
                        productName:
                            'Bodyguard Dog T-Shirt, Police Dog T-Shirt, Hat and Shoes Funny Dog Costume Cute Dog Clothes for Pet Accessories',
                        productprice: '€ 12',
                        productUrl:
                            'https://julia.primeshaun.in/uploads/aaeef3fdae4f3d9da508abfd6ddaa1151b6eb332.jpg',
                        location: 'Brokopondo',
                      );
                    }));
                  },
                  child: const ProductCard(
                    imageUrl:
                        "https://julia.primeshaun.in/uploads/aaeef3fdae4f3d9da508abfd6ddaa1151b6eb332.jpg",
                    time: '10 mins ago',
                    title:
                        'Bodyguard Dog T-Shirt, Police Dog T-Shirt, Hat and Shoes Funny Dog Costume Cute Dog Clothes for Pet Accessories',
                    location: 'Brokopondo',
                    price: "€ 12",
                  ),
                ),
              ],
            ),

            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: 'Sony Camera',
            //             productprice: '\$2300',
            //             productUrl:
            //                 'https://media.istockphoto.com/photos/camera-isolated-on-white-background-with-clipping-path-mirrorless-picture-id1140393948?k=20&m=1140393948&s=612x612&w=0&h=MS3Uq-TKZq2r19BoBaOKR7gf_umLNT3GZKTXkI2zRcw=',
            //             location: '',
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://media.istockphoto.com/photos/camera-isolated-on-white-background-with-clipping-path-mirrorless-picture-id1140393948?k=20&m=1140393948&s=612x612&w=0&h=MS3Uq-TKZq2r19BoBaOKR7gf_umLNT3GZKTXkI2zRcw=",
            //         time: '10 mins ago',
            //         title: 'Sony Camera',
            //         location: 'Bangaluru,Saltlake',
            //         price: "\$2300",
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: 'Swipt Desire Car',
            //             productprice: '\$21300',
            //             productUrl:
            //                 'https://imgd-ct.aeplcdn.com/370x208/n/cw/ec/106257/venue-exterior-right-front-three-quarter-2.jpeg?isig=0&q=75',
            //             location: '',
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://imgd-ct.aeplcdn.com/370x208/n/cw/ec/106257/venue-exterior-right-front-three-quarter-2.jpeg?isig=0&q=75",
            //         time: '10 mins ago',
            //         title: 'Swipt Desire Car',
            //         location: 'Bangaluru,Saltlake',
            //         price: "\$21300",
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: 'Sofa ',
            //             productprice: '\$200',
            //             productUrl:
            //                 'https://rukminim1.flixcart.com/image/150/150/knqd3m80/sofa-set/2/0/l/cream-brown-polycotton-wxq-sm-01-3-2-1-1-mofi-sofas-na-original-imag2chzstzc6cgq.jpeg?q=70',
            //             location: '',
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://rukminim1.flixcart.com/image/150/150/knqd3m80/sofa-set/2/0/l/cream-brown-polycotton-wxq-sm-01-3-2-1-1-mofi-sofas-na-original-imag2chzstzc6cgq.jpeg?q=70",
            //         time: '10 mins ago',
            //         title: 'Wooden Sofa ',
            //         location: 'Bangaluru,Saltlake',
            //         price: "\$200",
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: 'Dumbles and Weights',
            //             productprice: '\$900',
            //             productUrl:
            //                 'https://rukminim1.flixcart.com/image/150/150/jms25jk0/dumbbell/e/p/r/pvc-combo16-na-8-krx-original-imaepy3rcgm3nsva.jpeg?q=70',
            //             location: '',
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://rukminim1.flixcart.com/image/150/150/jms25jk0/dumbbell/e/p/r/pvc-combo16-na-8-krx-original-imaepy3rcgm3nsva.jpeg?q=70",
            //         time: '10 mins ago',
            //         title: 'Dumbles and Weights',
            //         location: 'Bangaluru,Saltlake',
            //         price: "\$900",
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: 'Hero Bicycle',
            //             productprice: '\$400',
            //             productUrl:
            //                 'https://rukminim1.flixcart.com/image/150/150/jlph9jk0/cycle/h/f/k/skyper-26t-sskp26bk0001-16-hero-original-imaf8ru5xysfgtmx.jpeg?q=70',
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://rukminim1.flixcart.com/image/150/150/jlph9jk0/cycle/h/f/k/skyper-26t-sskp26bk0001-16-hero-original-imaf8ru5xysfgtmx.jpeg?q=70",
            //         time: '10 mins ago',
            //         title: 'Hero Bicycle',
            //         location: 'Bangaluru,Saltlake',
            //         price: '\$400',
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: ' Sony Projector',
            //             productprice: '\$1400',
            //             productUrl:
            //                 'https://rukminim1.flixcart.com/image/150/150/kge0n0w0/projector/m/q/3/i9-classsic-hd-720p-8908012116066-egate-original-imafwnfzxqp3yymc.jpeg?q=70',
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://rukminim1.flixcart.com/image/150/150/kge0n0w0/projector/m/q/3/i9-classsic-hd-720p-8908012116066-egate-original-imafwnfzxqp3yymc.jpeg?q=70",
            //         time: '10 mins ago',
            //         title: 'Sony Projector',
            //         location: 'Bangaluru,Saltlake',
            //         price: "\$1400",
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: 'Dell Laptop max pro',
            //             productprice: '\$3400',
            //             productUrl:
            //                 "https://rukminim1.flixcart.com/image/150/150/ktop5e80/computer/f/p/w/km513ua-l503ts-thin-and-light-laptop-asus-original-imag6yt6ftegd5bx.jpeg?q=70",
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://rukminim1.flixcart.com/image/150/150/ktop5e80/computer/f/p/w/km513ua-l503ts-thin-and-light-laptop-asus-original-imag6yt6ftegd5bx.jpeg?q=70",
            //         time: '10 mins ago',
            //         title: 'Dell Laptop max pro',
            //         location: 'Bangaluru,Saltlake',
            //         price: '\$3400',
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: 'Boat Headset 300',
            //             productprice: '\$2400',
            //             productUrl:
            //                 "https://rukminim1.flixcart.com/image/612/612/krtjgcw0/headphone/d/9/g/au-mh501-maono-original-imag5j35rffkwpac.jpeg?q=70",
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://rukminim1.flixcart.com/image/612/612/krtjgcw0/headphone/d/9/g/au-mh501-maono-original-imag5j35rffkwpac.jpeg?q=70",
            //         time: '10 mins ago',
            //         title: 'Boat Headset 300',
            //         location: 'Bangaluru,Saltlake',
            //         price: '\$2400',
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: ' white Sneakers ',
            //             productprice: '\$400',
            //             productUrl:
            //                 "https://apollo-singapore.akamaized.net/v1/files/0ei7i7uqb2gf1-IN/image;s=780x0;q=60",
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://apollo-singapore.akamaized.net/v1/files/0ei7i7uqb2gf1-IN/image;s=780x0;q=60",
            //         time: '10 mins ago',
            //         title: 'white Sneakers ',
            //         location: 'Bangaluru,Saltlake',
            //         price: "\$400",
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(context,
            //             MaterialPageRoute(builder: (context) {
            //           return const ProductDetailsScreen(
            //             productName: ' Boys Shirts ',
            //             productprice: '\$1200',
            //             productUrl:
            //                 "https://apollo-singapore.akamaized.net/v1/files/2c868rn4iki4-IN/image;s=780x0;q=60",
            //             location: '',
            //           );
            //         }));
            //       },
            //       child: const ProductCard(
            //         imageUrl:
            //             "https://apollo-singapore.akamaized.net/v1/files/2c868rn4iki4-IN/image;s=780x0;q=60",
            //         time: '10 mins ago',
            //         title: 'Boys Shirts',
            //         location: 'Bangaluru,Saltlake',
            //         price: "\$1200",
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
