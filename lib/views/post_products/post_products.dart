import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/dynamic_form_model.dart';
import 'package:julia/data/repository/dynamic_form_repo.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PostProductsView extends StatefulWidget {
  const PostProductsView(
      {super.key, required this.categoryId, required this.subCategoryId});
  final String categoryId;
  final String subCategoryId;

  @override
  State<PostProductsView> createState() => _PostProductsViewState();
}

class _PostProductsViewState extends State<PostProductsView> {
  //List of items in our dropdown menu

  var location = [
    'Brokopondo',
    'Commewijne',
    'Coronie',
    'Marowijne',
    'Nickerie',
    'Para',
    'Paramaribo',
    'Saramacca',
    'Sipaliwini',
    'Wanica',
  ];
  // Initial Selected Value

  var _locationValue;

  TextEditingController titleController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  XFile? image;
  late Future<List<DynamicForm>> dynamicFormData;
  final _secureStorage = FlutterSecureStorage();
  List<Asset> images = <Asset>[];
  List<Asset> resultList = <Asset>[];
  String error = 'No Error Dectected';
  Future<void> loadAssets() async {
    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 20,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: const CupertinoOptions(takePhotoIcon: 'Chat'),
          materialOptions: const MaterialOptions(
            actionBarColor: '#abcdef',
            actionBarTitle: 'Example App',
            allViewTitle: "All Photes",
            useDetailsView: false,
            selectCircleStrokeColor: '#000000',
          ));
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
  }

//   static Future<String> uploadMultipleImage({required List<File> files}) async {
// // string to uri
//     var uri = Uri.parse("your api url");
//     print("image upload URL - $uri");
// // create multipart request
//     var request = new http.MultipartRequest("POST", uri);

//     for (var file in files) {
//       String fileName = file.path.split("/").last;
//       var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));

//       // get file length

//       var length = await file.length(); //imageFile is your image file
//       print("File lenght - $length");
//       print("fileName - $fileName");
//       // multipart that takes file
//       var multipartFileSign =
//           http.MultipartFile('images[]', stream, length, filename: fileName);

//       request.files.add(multipartFileSign);
//     }

//     Map<String, String> headers = {
//       "Accept": "application/json",
//       "Authorization":
//           "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMiwiZXhwIjoxNjE3NTQyNDE0LCJpc3MiOiJsb2NhbGhvc3QiLCJpYXQiOjE2MTcxODI0MTR9.dGRbINOdx_tf417fpsjdQ5CR7uGULs98FjLGm2w4kRY"
//     }; // ignore this headers if there is no authentication
//     print("headers - $headers}");
// //add headers
//     request.headers.addAll(headers);

// //adding params
//     request.fields['heading'] = "heading";
//     request.fields['description'] = "description";
//     request.fields['mobile'] = "mobile";
//     request.fields['email'] = "email";
//     request.fields['category'] = "1";
//     request.fields['location_type'] = "1";
//     request.fields['location'] = "location";
//     request.fields['lat'] = "12";
//     request.fields['lng'] = "123";
//     request.fields['price'] = "1231";
//     request.fields['sub_category'] = "3";

// // send
//     var response = await request.send();

//     print(response.statusCode);

//     var res = await http.Response.fromStream(response);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Item form is statuscode 200");
//       print(res.body);
//       var responseDecode = json.decode(res.body);

//       if (responseDecode['status'] == true) {
//         return res.body;
//       } else {
//         return res.body;
//       }
//     }
//   }

  postProductData() async {
    for (var i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      List<int> imageData = byteData.buffer.asInt8List();

      http.MultipartFile multipartFile = MultipartFile.fromBytes(
        images[i].name!,
        imageData,
      );
      var authToken = await _secureStorage.read(key: 'token');
      var authUser = await _secureStorage.read(key: 'userId');
      print(authToken);
      print(_locationValue);
      var response = http.post(Uri.parse('$baseUrl/user/create/new/ad'),
          headers: {
            HttpHeaders.authorizationHeader: authToken!,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: jsonEncode(<String, dynamic>{
            "post_category": widget.categoryId,
            "post_subcategory": widget.subCategoryId,
            "post_user_id": authUser,
            "fields": '',
            "post_location": _locationValue,
            "post_title": titleController.text,
            "post_image": multipartFile.filename,
            "post_price": priceController.text,
            "post_description": descController.text,
            "auth_name": nameController.text,
          }));
      return response;
    }
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(asset: asset, width: 300, height: 300);
      }),
    );
  }

  @override
  void initState() {
    dynamicFormData = getDynamicForm(widget.subCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Sell Your Products',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: FutureBuilder<List<DynamicForm>>(
          future: dynamicFormData,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                        TextField(
                          controller: titleController,
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
                        const Text(
                          'Brand*',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: brandController,
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
                        const Text(
                          'Description of what you sell*',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: descController,
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          maxLines: null,
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
                        const Text(
                          'Price',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: priceController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 200, child: buildGridView()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload Photo',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CupertinoButton(
                          color: Colors.green,
                          onPressed: loadAssets,
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
                          'Location',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownButton<String>(
                          enableFeedback: true,
                          hint: const Text('Location'),
                          isExpanded: true,
                          value: _locationValue,
                          items: location
                              .map((String item) => DropdownMenuItem(
                                  value: item, child: Text(item)))
                              .toList(),
                          onChanged: (String? d) {
                            setState(() {
                              _locationValue = d!;
                            });
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
                          'Your Name',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                  // const Divider(
                  //   color: Colors.grey,
                  // ),
                  // FutureBuilder<List<DynamicForm>>(
                  //     future: dynamicFormData,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         List<DynamicForm>? data = snapshot.data;
                  //         return SizedBox(
                  //           height: 500,
                  //           width: MediaQuery.of(context).size.width,
                  //           child: ListView.builder(
                  //               itemCount: data!.length,
                  //               itemBuilder: (context, index) {
                  //                 var currentItem = data[index];
                  //                 List<String> options =
                  //                     currentItem.schema.fielddata.split(',');
                  //                 return Column(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       currentItem.schema.field,
                  //                       style: const TextStyle(fontSize: 16),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 550,
                  //                       width:
                  //                           MediaQuery.of(context).size.width,
                  //                       child: ListView.builder(
                  //                           scrollDirection: Axis.horizontal,
                  //                           itemCount: options.length,
                  //                           itemBuilder: (context, index) {
                  //                             return SizedBox(
                  //                               height: 20,
                  //                               width: 100,
                  //                               child: Row(
                  //                                 children: [
                  //                                   SizedBox(
                  //                                     height: 20,
                  //                                     width: 100,
                  //                                     child: RadioListTile(
                  //                                       title: Text(
                  //                                           options[index]),
                  //                                       value: options[index],
                  //                                       groupValue: options,
                  //                                       onChanged: (value) {
                  //                                         setState(() {
                  //                                           options[index] =
                  //                                               value
                  //                                                   .toString();
                  //                                         });
                  //                                       },
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             );
                  //                           }),
                  //                     )
                  //                   ],
                  //                 );
                  //               }),
                  //         );
                  //       } else if (snapshot.hasError) {
                  //         return Text("${snapshot.error}");
                  //       } else {
                  //         return const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }
                  //     }),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                        color: Colors.green,
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          postProductData();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
