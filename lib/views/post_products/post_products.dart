import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:julia/const/const.dart';
import 'package:julia/const/location_data.dart';
import 'package:julia/data/model/dynamic_form_model.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:julia/data/repository/get_user_details_repo.dart';
import 'package:julia/provider/get_user_details_proider.dart';
import 'package:julia/provider/location_provider.dart';
import 'package:provider/provider.dart';

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
  late Future<Userdetails> getUserData;
// creating instance of dio
  Dio dio = Dio();
  TextEditingController titleController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? image;
  late Future<List<DynamicForm>> dynamicFormData;
  final _secureStorage = const FlutterSecureStorage();
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
    print("Image List Length:  ${imageFileList!.length.toString()}");
  }

//function to upload the image to php server
  void _upload(File file) async {
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

//using dio to post imagename to the mongodg api and the name we get from the php server
    dio.post("https://julia.sr/upload.php", data: data).then((response) {
      imageNames.add(response.data);
      print('image list -------->$imageNames');
      postProductData(imageNames);
    }).catchError((error) => print(error));
  }

  void postProductData(List imageName) async {
    var authToken = await _secureStorage.read(key: 'token');
    var authUser = await _secureStorage.read(key: 'userId');
    var response = await http.post(Uri.parse('$baseUrl/user/create/new/ad'),
        headers: {
          HttpHeaders.authorizationHeader: authToken!,
          HttpHeaders.contentTypeHeader: "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "post_category": widget.categoryId,
          "post_subcategory": widget.subCategoryId,
          "post_user_id": authUser,
          "fields": '{}',
          "location": _dropDownValue,
          'city': cityController.text,
          "post_title": titleController.text,
          "post_image": json.encode(imageName),
          "post_price": priceController.text,
          "post_description": descController.text,
          "auth_name": widget.userName,
        }));
    print('json encoded data------>${json.encode(imageName)}');
    if (response.statusCode == 200) {
      print('status code 200 is ---->${response.body}');
    } else {
      print('location----->${locationController.text}');
      print('getting error ------>${response.body}');
    }
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context); //It will redirect  after 3 seconds
    });
  }

  @override
  void initState() {
    getUserData = getUserDetails();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final location = Provider.of<LocationProvider>(context);
    final profiledata = Provider.of<GetProfileDetailsProvider>(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
            title: const Text(
              'Sell Your Products',
              style: TextStyle(
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
                      const Text(
                        'Add Title*',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the title';
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
                      const Text(
                        'Brand*',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: brandController,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the brand name';
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
                      const Text(
                        'Description of what you sell*',
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
                            return 'Please enter the description';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
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
                      const Text(
                        'Price',
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
                            return 'Please enter the price';
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
                              itemBuilder: (BuildContext context, int index) {
                                return Image.file(
                                  File(imageFileList![index].path),
                                  fit: BoxFit.cover,
                                );
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CupertinoButton(
                        color: greenColor,
                        onPressed: () {
                          selectImages();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.image),
                            Text(
                              'Upload Image',
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
                      const Text(
                        'District',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DropdownButton(
                        value: _dropDownValue,
                        hint: const Text('District'),
                        items: [
                          DropdownMenuItem<String>(
                              value: '${locationData[0]["_id"]}',
                              child:
                                  Text('${locationData[0]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[1]["_id"]}',
                              child:
                                  Text('${locationData[1]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[2]["_id"]}',
                              child:
                                  Text('${locationData[2]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[3]["_id"]}',
                              child:
                                  Text('${locationData[3]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[4]["_id"]}',
                              child:
                                  Text('${locationData[4]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[5]["_id"]}',
                              child:
                                  Text('${locationData[5]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[6]["_id"]}',
                              child:
                                  Text('${locationData[6]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[7]["_id"]}',
                              child:
                                  Text('${locationData[7]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[8]["_id"]}',
                              child:
                                  Text('${locationData[8]["location_name"]}')),
                          DropdownMenuItem<String>(
                              value: '${locationData[9]["_id"]}',
                              child:
                                  Text('${locationData[9]["location_name"]}')),
                        ],
                        onChanged: (items) {
                          setState(
                            () {
                              _dropDownValue = items.toString();
                              location.getCityName(_dropDownValue);
                              print("city ------>${location.cityData}");
                              print(_dropDownValue);
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
                      const Text(
                        'Area',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      EasyAutocomplete(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
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
                      const Text(
                        'Your Name',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: profiledata.getUserData.data[0].userName,
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
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (imageFileList!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: redColor,
                                margin: const EdgeInsets.only(
                                    top: 400, bottom: 400, left: 30, right: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                content: const Center(
                                  child: Text(
                                    'please select some image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            //it will show a toast in the middle
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: greenColor,
                                margin: const EdgeInsets.only(
                                    top: 400, bottom: 400, left: 30, right: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                content: const Center(
                                  child: Text(
                                    'Posting data...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );

                            print('save button pressed');
                            for (var i = 0; i < imageFileList!.length; i++) {
                              _upload(File(imageFileList![i].path));
                            }
                            startTimer();
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
      ),
    );
  }
}
