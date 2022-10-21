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
  XFile? image;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();

  editProfile() async {
    var authToken = await _secureStorage.read(key: 'token');
    var authUser = await _secureStorage.read(key: 'userId');
    print(authToken);
    print(authUser);
    final response = http.post(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
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
                          image = img;
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
                          image = img;
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
                  editProfile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
