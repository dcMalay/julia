import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:julia/const/const.dart';
import 'package:julia/helper/email_checker.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../provider/google_sign_in_provider.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _emailController;
  late final TextEditingController _numberController;
  late final TextEditingController _stateController;
  late final TextEditingController _districtController;
  late final TextEditingController _areaController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _numberController = TextEditingController();
    _stateController = TextEditingController();
    _districtController = TextEditingController();
    _areaController = TextEditingController();
    _emailController = TextEditingController();

    super.initState();
  }

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
          "user_name": FirebaseAuth.instance.currentUser!.displayName ??
              _nameController.text,
          "user_phone": _numberController.text,
          "user_email":
              FirebaseAuth.instance.currentUser!.email ?? _emailController.text,
          "user_image":
              FirebaseAuth.instance.currentUser!.photoURL ?? imageName,
          "user_about": _descController.text,
          "user_city": _areaController.text,
          "user_address1": _districtController.text,
          "user_state": _stateController.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      print("response from send profile name------->${response.body}");
    } else {
      print('getting error--->${response.statusCode}');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _numberController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _areaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
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
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: () {},
                  child: image == null
                      ? InkWell(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final img = await picker.pickImage(
                                source: ImageSource.gallery);
                            setState(() {
                              image = File(img!.path);
                            });
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
                            // backgroundImage: NetworkImage(
                            //   user!.photoURL ??
                            //       'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                            // ),

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                user!.photoURL ??
                                    'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            //  NetworkImage(
                            //     provider.user.photoUrl.toString()),
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final img = await picker.pickImage(
                                source: ImageSource.gallery);
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: user!.displayName ?? 'Full Name',
                      border: const OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                      hintText: 'Description', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: user.email ?? "Email",
                      border: const OutlineInputBorder()),
                  validator: (input) =>
                      input!.isValidEmail() ? null : "Check your email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _numberController,
                  decoration: InputDecoration(
                      hintText: user.phoneNumber ?? 'Contact Number',
                      border: const OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                      hintText: 'State', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _districtController,
                  decoration: const InputDecoration(
                      hintText: 'District', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _areaController,
                  decoration: const InputDecoration(
                      hintText: 'Area', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CupertinoButton(
                    color: greenColor,
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _upload(File(image!.path));
                      // uploadImage();
                      Timer(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
