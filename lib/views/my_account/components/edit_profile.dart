import 'dart:convert';
import 'dart:io';
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
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();
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

  // Future<void> uploadImage(String filename, String url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));

  //   request.files.add(
  //     await http.MultipartFile.fromPath('picture', filename),
  //   );

  //   var res = await request.send();
  // }
  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    //   var uri = Uri.parse('$baseUrl/user/addprofilepicture/$userId');
    var uri = Uri.parse('http://mouldstaging.com/upload.php');
    var request = http.MultipartRequest('POST', uri);

    // request.fields['title'] = "Static title";

    var multiport = http.MultipartFile('file', stream, length);

    request.files.add(multiport);

    var response = await request.send();

    print("response----------->${response.statusCode}");
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('image uploaded');
    } else {
      print('failed');
      setState(() {
        showSpinner = false;
      });
    }
  }

  editProfileDetails() async {
    var authToken = await _secureStorage.read(key: 'token');
    var authUser = await _secureStorage.read(key: 'userId');
    print(authToken);
    print(authUser);
    final response = await http.post(
      Uri.parse('$baseUrl/user/newprofile/$authUser'),
      headers: {
        HttpHeaders.authorizationHeader: authToken!,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      body: json.encode(
        {
          "user_name": _userName.text,
          "user_phone": _phoneNumber.text,
        },
      ),
    );
    if (response.statusCode == 200) {
      print("response from send profile name------->${response.body}");
    } else {
      print('getting error');
    }
  }

  @override
  void dispose() {
    _userName.clear();
    _phoneNumber.clear();
    super.dispose();
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
              controller: _userName,
              decoration: const InputDecoration(
                hintText: 'Edit Name',
              ),
            ),
            TextField(
              controller: _phoneNumber,
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
                  uploadImage();
                  editProfileDetails();
                  Navigator.pop(context);
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