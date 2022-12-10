import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/sub_category_model.dart';
import 'package:julia/data/repository/sub_category_repo.dart';
import 'package:julia/views/explore/subcategory_search_screen.dart';

class SubCategoryScreenforSearch extends StatefulWidget {
  const SubCategoryScreenforSearch({super.key, required this.categoryId});
  final String categoryId;
  @override
  State<SubCategoryScreenforSearch> createState() =>
      _SubCategoryScreenforSearchState();
}

class _SubCategoryScreenforSearchState
    extends State<SubCategoryScreenforSearch> {
  late Future<List<SubCategories>> sCategory;
  @override
  void initState() {
    sCategory = getSubcategory(widget.categoryId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: greenColor,
            centerTitle: true,
            title: Text(
              "choose_subcategory".tr(),
              style: TextStyle(color: Colors.white),
            )),
        body: FutureBuilder<List<SubCategories>>(
            future: sCategory,
            builder: (context, snapshot) {
              List<SubCategories>? data = snapshot.data;
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 130,
                      childAspectRatio: .1 / .1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
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
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SubcategorySearchScreen(
                                          subcategoryId: currentItem.id),
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
                            title: Text(
                              currentItem.postSubcategoryName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
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
      ),
    );
  }
}
