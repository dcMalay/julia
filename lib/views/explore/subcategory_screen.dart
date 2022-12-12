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

  // final List<Map<String, dynamic>> subcategorydata = [
  //   {
  //     "id": "634cf67834b3e19013baedcb",
  //     "subcategory": ['Audio, Tv and Photo', 'Other']
  //   },
  //   {
  //     "id": "634cf68a34b3e19013baedcd",
  //     "subcategory": [
  //       'Auto hifi',
  //       'Auto',
  //       'Auto Parts',
  //       'Car miscellaneous',
  //       'Other'
  //     ]
  //   },
  //   {
  //     "id": "634cf69434b3e19013baedcf",
  //     "subcategory": ['Body care', 'Other']
  //   },
  //   {
  //     "id": "634cf69e34b3e19013baedd1",
  //     "subcategory": ['Nothing', 'Boat parts', 'Other']
  //   },
  //   {
  //     "id": "634cf6a734b3e19013baedd3",
  //     "subcategory": ['Tools', 'Materials', 'Other']
  //   },
  //   {
  //     "id": "634cf6af34b3e19013baedd5",
  //     "subcategory": ['Moped/Motorcycle for Sale', 'Moped Parts ', 'Other']
  //   },
  //   {
  //     "id": "634cf6b834b3e19013baedd7",
  //     "subcategory": ['Computer games ', 'Computers and Laptops ', 'Other']
  //   },
  //   {
  //     "id": "634cf6c334b3e19013baedd9",
  //     "subcategory": ['Vegetables and Fruits ', 'Poultry and Other ', 'Other']
  //   },
  //   {
  //     "id": "634cf6d634b3e19013baede0",
  //     "subcategory": ['Animal Accessories', 'Other']
  //   },
  //   {
  //     "id": "634cf6e034b3e19013baede6",
  //     "subcategory": ['Bicycles for Sale ', 'Bicycle parts', 'Other']
  //   },
  //   {
  //     "id": "634cf6eb34b3e19013baede8",
  //     "subcategory": ['Free', 'Other']
  //   },
  //   {
  //     "id": "634cf6f234b3e19013baedea",
  //     "subcategory": ['Curious', 'Other']
  //   },
  //   {
  //     "id": "634cf6f934b3e19013baedec",
  //     "subcategory": [
  //       'Household wanted ',
  //       'Kitchen and accessories ',
  //       'Furniture ',
  //       'Other'
  //     ]
  //   },
  //   {
  //     "id": "634cf70134b3e19013baedf7",
  //     "subcategory": ['Office furniture', 'Other']
  //   },
  //   {
  //     "id": "634cf70b34b3e19013baedff",
  //     "subcategory": ['Clothing', 'Furniture ', 'Other']
  //   },
  //   {
  //     "id": "634cf71134b3e19013baee01",
  //     "subcategory": ['Girls', 'Clothing ', 'Other']
  //   },
  //   {
  //     "id": "634cf71934b3e19013baee03",
  //     "subcategory": ['Boys', ' Clothing', 'Other']
  //   },
  //   {
  //     "id": "634cf72634b3e19013baee05",
  //     "subcategory": ['Medical equipment ', 'Other']
  //   },
  //   {
  //     "id": "634cf72e34b3e19013baee07",
  //     "subcategory": ['Music and Instruments ', 'Other']
  //   },
  //   {
  //     "id": "634cf73734b3e19013baee09",
  //     "subcategory": [
  //       'Wanted handymen',
  //       'Handymen offered',
  //       'Vacancies',
  //       'Other'
  //     ]
  //   },
  //   {
  //     "id": "634cf74034b3e19013baee0b",
  //     "subcategory": ['Jewellery, Bags and luxury products', 'Other']
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    print(widget.categoryId);
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
              style: const TextStyle(color: Colors.white),
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
                      // print(subcategorydata[index]['subcategory'][index]);
                      // print('api --->${currentItem.postSubcategoryName}');
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
                              // context.locale.toString() == 'nl'
                              currentItem.postSubcategoryName,
                              // ignore: iterable_contains_unrelated_type
                              // : "${subcategorydata[index]['id']}" ==
                              //         widget.categoryId
                              //     ? "${subcategorydata[index]['subcategory'][index]}"
                              //     : '',
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
