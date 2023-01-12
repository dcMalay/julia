import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:julia/const/const.dart';
import 'package:julia/const/location_data.dart';
import 'package:julia/data/model/dynamic_form_model.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:julia/data/repository/get_user_details_repo.dart';
import 'package:julia/data/repository/post_products_repo.dart';
import 'package:julia/provider/get_user_details_proider.dart';
import 'package:julia/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_register/login.dart';

// ignore: must_be_immutable
class PostProductsView extends StatefulWidget {
  const PostProductsView(
      {super.key,
      required this.categoryId,
      required this.subCategoryId,
      required this.userName});
  final String categoryId;
  final String subCategoryId;
  final String userName;
  @override
  State<PostProductsView> createState() => _PostProductsViewState();
}

class _PostProductsViewState extends State<PostProductsView> {
  var status;
  void isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  late Future<Userdetails> getUserData;
// creating instance of dio

  TextEditingController titleController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? image;
  late Future<List<DynamicForm>> dynamicFormData;

  var _dropDownValue;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];
//function to select image and add the images to the imageFileList array
  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    //using set state to refresh the page to show the image to the grid
    setState(() {});
  }

  void clearImages() {
    setState(() {});
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context); //It will redirect  after 3 seconds
    });
  }

  @override
  void initState() {
    isloggedIn();

    getUserData = getUserDetails();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final location = Provider.of<LocationProvider>(context);
    final profiledata = Provider.of<GetProfileDetailsProvider>(context);
    late FormData data;
    //function to upload the image to php server
    void _upload(File file) async {
      String fileName = file.path.split('/').last;
      data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: status == true
          ? Scaffold(
              appBar: AppBar(
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: greenColor,
                  title: Text(
                    'sell_your_products'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'add_title'.tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_the_title'.tr();
                                }
                                return null;
                              },
                              controller: titleController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'brand'.tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: brandController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_the_brand_name'.tr();
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'description_of_what_you_sell'.tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: descController,
                              keyboardType: TextInputType.multiline,
                              minLines: 4,
                              maxLines: null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_the_description'.tr();
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'price'.tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_the_price'.tr();
                                }
                                return null;
                              },
                              controller: priceController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 130,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                    itemCount: imageFileList!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 3.0,
                                      crossAxisSpacing: 3.0,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          Image.file(
                                            File(imageFileList![index].path),
                                            fit: BoxFit.cover,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                imageFileList!.removeAt(index);
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: const Center(
                                                child: Icon(Icons.clear),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'maximum_file_size'.tr(),
                              style: TextStyle(color: redColor, fontSize: 12),
                            ),
                            CupertinoButton(
                              color: greenColor,
                              onPressed: () {
                                selectImages();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.image),
                                  Text(
                                    'upload_image'.tr(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'district'.tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButton(
                              value: _dropDownValue,
                              hint: Text(
                                'district'.tr(),
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                    value: '${locationData[0]["_id"]}',
                                    child: Text(
                                        '${locationData[0]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[1]["_id"]}',
                                    child: Text(
                                        '${locationData[1]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[2]["_id"]}',
                                    child: Text(
                                        '${locationData[2]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[3]["_id"]}',
                                    child: Text(
                                        '${locationData[3]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[4]["_id"]}',
                                    child: Text(
                                        '${locationData[4]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[5]["_id"]}',
                                    child: Text(
                                        '${locationData[5]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[6]["_id"]}',
                                    child: Text(
                                        '${locationData[6]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[7]["_id"]}',
                                    child: Text(
                                        '${locationData[7]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[8]["_id"]}',
                                    child: Text(
                                        '${locationData[8]["location_name"]}')),
                                DropdownMenuItem<String>(
                                    value: '${locationData[9]["_id"]}',
                                    child: Text(
                                        '${locationData[9]["location_name"]}')),
                              ],
                              onChanged: (items) {
                                setState(
                                  () {
                                    _dropDownValue = items.toString();
                                    location.getCityName(_dropDownValue);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'area'.tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            EasyAutocomplete(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please_enter_city'.tr();
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: cityController,
                              suggestions: location.cityData,
                              onChanged: (value) {},
                              onSubmitted: (value) {},
                            ),
                          ],
                        ),
                      ),
                      // const HtmlForm(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'your_name'.tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText:
                                    profiledata.getUserData.data[0].userName,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CupertinoButton(
                            color: greenColor,
                            child: Text(
                              'submit'.tr(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (imageFileList!.isEmpty) {
                                  QuickAlert.show(
                                    confirmBtnText: "okay".tr(),
                                    context: context,
                                    type: QuickAlertType.warning,
                                    text: 'please_select_image'.tr(),
                                  );
                                } else {
                                  for (var i = 0;
                                      i < imageFileList!.length;
                                      i++) {
                                    _upload(File(imageFileList![i].path));
                                  }
                                  Timer(const Duration(seconds: 2), () {
                                    postProducts(
                                      data,
                                      widget.categoryId,
                                      widget.subCategoryId,
                                      _dropDownValue,
                                      cityController.text,
                                      titleController.text,
                                      priceController.text,
                                      descController.text,
                                      profiledata.getUserData.data[0].userName,
                                    );
                                  });

                                  Navigator.pop(context);
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: 'post_success'.tr(),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CupertinoButton(
                  color: greenColor,
                  child: Text('login'.tr()),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(1, 0), end: Offset.zero)
                              .animate(animation),
                          child: child,
                        );
                      },
                    ));
                  }),
            ),
    );
  }
}
