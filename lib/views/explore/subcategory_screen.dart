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
  late Future<List<SubCategories>> ensCategory;
  // List<String> filterData = widget.categoryId == '634cf67834b3e19013baedcb'
  //       ? ['Audio, Tv and Photo', 'Other']
  //       : widget.categoryId == '634cf68a34b3e19013baedcd'
  //        ? ['Auto hifi', 'Auto', 'Auto Parts', 'Car miscellaneous', 'Other']:widget.categoryId == '634cf69434b3e19013baedcf'
  //           ? ['Body care', 'Other']: widget.categoryId == '634cf69e34b3e19013baedd1'
  //             ? ['Nothing', 'Boat parts', 'Other'] : widget.categoryId == '634cf6a734b3e19013baedd3'
  //                   ? ['Tools', 'Materials', 'Other']
  //       : widget.categoryId == '634cf6af34b3e19013baedd5'
  //                           ? [
  //                               'Moped/Motorcycle for Sale',
  //                               'Moped Parts ',
  //                               'Other'
  //                             ]: widget.categoryId == '634cf6b834b3e19013baedd7'
  //                               ? [
  //                                   'Computer games ',
  //                                   'Computers and Laptops ',
  //                                   'Other'
  //                                 ]
  //                               : widget.categoryId ==
  //                                       '634cf6c334b3e19013baedd9'
  //                                   ? [
  //                                       'Vegetables and Fruits ',
  //                                       'Poultry and Other ',
  //                                       'Other'
  //                                     ]
  //                                   : widget.categoryId ==
  //                                           '634cf6d634b3e19013baede0'
  //                                       ? ['Animal Accessories', 'Other']: widget.categoryId ==
  //                                               '634cf6e034b3e19013baede6'
  //                                           ?  ['Bicycles for Sale ', 'Bicycle parts', 'Other']
  //                                           : widget.categoryId ==
  //                                                   '634cf6eb34b3e19013baede8'
  //                                               ? ['Free', 'Other']
  //                                               : widget.categoryId ==
  //                                                       '634cf6f234b3e19013baedea'
  //                                                   ? ['Curious', 'Other']
  //                                                   : widget.categoryId ==
  //                                                           '634cf6f934b3e19013baedec'
  //                                                       ?  [
  //                                                             'Household wanted ',
  //                                                             'Kitchen and accessories ',
  //                                                             'Furniture ',
  //                                                             'Other'
  //                                                           ]   : widget.categoryId ==
  //                                                               '634cf70134b3e19013baedf7'
  //                                                           ?['Office furniture', 'Other']
  //                                                           : widget.categoryId ==
  //                                                                   '634cf70b34b3e19013baedff'
  //                                                               ?  ['Clothing', 'Furniture ', 'Other']
  //                                                               : widget.categoryId ==
  //                                                                   '634cf71134b3e19013baee01'
  //                                                               ? ['Girls', 'Clothing ', 'Other']
  //                                                               : widget.categoryId ==
  //                                                                   '634cf71934b3e19013baee03'
  //                                                               ? ['Boys', ' Clothing', 'Other']
  //                                                               : widget.categoryId ==
  //                                                                   '634cf72634b3e19013baee05'
  //                                                               ? ['Medical equipment ', 'Other']
  //                                                               : widget.categoryId ==
  //                                                                   '634cf72e34b3e19013baee07'
  //                                                               ? ['Music and Instruments ', 'Other']
  //                                                               : widget.categoryId ==
  //                                                                   '634cf73734b3e19013baee09'
  //                                                               ? [
  //                                                                   'Wanted handymen',
  //                                                                   'Handymen offered',
  //                                                                   'Vacancies',
  //                                                                   'Other'
  //                                                                         ]
  //                                                                 : widget.categoryId ==
  //                                                                   '634cf74034b3e19013baee0b'
  //                                                               ? ['Jewellery, Bags and luxury products', 'Other']
  //                                                              :[];

  @override
  void initState() {
    sCategory = getSubcategory(
      widget.categoryId,
    );
    ensCategory = getenSubcategory(widget.categoryId);
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
              style: const TextStyle(color: Colors.white),
            )),
        body: FutureBuilder<List<SubCategories>>(
            future: context.locale.toString() == 'nl' ? sCategory : ensCategory,
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
