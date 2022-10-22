import 'package:flutter/material.dart';
import 'package:julia/data/model/sub_category_model.dart';
import 'package:julia/data/repository/sub_category_repo.dart';
import 'package:julia/views/post_products/post_products.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  late Future<List<SubCategories>> sCategory;
  @override
  void initState() {
    sCategory = getSubcategory(widget.categoryId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Choose Subcategory",
            style: TextStyle(color: Colors.black),
          )),
      body: FutureBuilder<List<SubCategories>>(
          future: sCategory,
          builder: (context, snapshot) {
            List<SubCategories>? data = snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    var currentItem = data[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
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
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              // reverseTransitionDuration: const Duration(seconds: 1),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      PostProductsView(
                                categoryId: widget.categoryId,
                                subCategoryId: currentItem.id,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                        title: Text(currentItem.postSubcategoryName),
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