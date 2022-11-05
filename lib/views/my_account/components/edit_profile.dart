import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:julia/const/const.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();
  //function to get the image from gallery
  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('no image selected');
    }
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

    Dio dio = Dio();

    dio.post("http://mouldstaging.com/upload.php", data: data).then((response) {
      return editProfileDetails(response.data);
    }).catchError((error) => print(error));
  }

  editProfileDetails(String imageName) async {
    var authToken = await _secureStorage.read(key: 'token');
    var authUser = await _secureStorage.read(key: 'userId');

    final response = await http.post(
      Uri.parse('$baseUrl/user/newprofile/$authUser'),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: json.encode(
        {
          "user_name": userName.text,
          "user_phone": phoneNumber.text,
          "user_image": imageName
        },
      ),
    );
    print(phoneNumber.text);
    print(userName.text);
    if (response.statusCode == 200) {
      print("response from send profile name------->${response.body}");
    } else {
      print('getting error');
    }
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: image == null
                  ? InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final img =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          image = File(img!.path);
                        });
                      },
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final img =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          image = File(img!.path);
                        });
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
            ),
            TextField(
              controller: userName,
              decoration: const InputDecoration(
                hintText: 'Edit Name',
              ),
            ),
            TextField(
              controller: phoneNumber,
              decoration: const InputDecoration(
                hintText: 'Edit Phone No.',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoButton(
                color: Colors.green,
                child: const Text("save"),
                onPressed: () {
                  print('save pressed');
                  _upload(File(image!.path));
                  // uploadImage();
                  Timer(const Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// function uploadfile(file) {


//                 return new Promise((resolve, reject) => {
//                     if (files.length == 0) {
//                         alert('Error : No file selected');
//                         return;
//                     }


//                     let allowed_mime_types = ['image/jpeg', 'image/png'];
//                     let allowed_size_mb = 2;

//                     if (allowed_mime_types.indexOf(file.type) == -1) {
//                         alert('Error : Incorrect file type');
//                         return;
//                     }

//                     if (file.size > allowed_size_mb * 1024 * 1024) {
//                         alert('Error : Exceeded size');
//                         return;
//                     }

//                     let data = new FormData();
//                     data.append('file', file);

//                     let request = new XMLHttpRequest();

//                     request.upload.onprogress = function(event) {
//                         let percent = Math.round(100 * event.loaded / event.total);
//                         console.log(`File is ${percent}% uploaded.`);
//                     };



//                     request.open('POST', 'upload.php');
//                     request.addEventListener('load', function(e) {
//                         resolve(request.response)
//                     });
//                     request.send(data);

//                 })

//             }