import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../const/const.dart';
import '../../../data/model/profile_details_model.dart';
import '../../../data/repository/get_user_details_repo.dart';

class AccountProfileDetailsScreen extends StatefulWidget {
  const AccountProfileDetailsScreen({super.key});

  @override
  State<AccountProfileDetailsScreen> createState() =>
      _AccountProfileDetailsScreenState();
}

class _AccountProfileDetailsScreenState
    extends State<AccountProfileDetailsScreen> {
  late Future<Userdetails> getUserData;

  @override
  void initState() {
    getUserData = getUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Userdetails>(
        future: getUserData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Userdetails? userData = snapshot.data;
            return Scaffold(
                appBar: AppBar(title: Text('profile_information'.tr())),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () async {},
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child:
                                        userData!.data[0].userImage.isNotEmpty
                                            ? Image.network(userData
                                                .data[0].userImage
                                                .toString())
                                            : Image.network(
                                                'https://www.julia.sr/assets/images/profilepic.webp',
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                              )),
                          Text(
                            "basic_information".tr(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "fullname".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: userData.data[0].userName,
                                  border: const OutlineInputBorder()),
                            ),
                          ),
                          Text(
                            "tell_julia_about_the_things_you_like".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: userData.data[0].userAbout,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Text(
                            "contact-information".tr(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "email_address".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: userData.user[0].userEmail,
                                  border: const OutlineInputBorder()),
                            ),
                          ),
                          Text(
                            "PhoneNumber".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: userData.user[0].userPhone,
                                  border: const OutlineInputBorder()),
                            ),
                          ),
                          Text(
                            "address_data".tr(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "address".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: userData.data[0].userCity,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Text(
                            "resort".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: userData.data[0].userState,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          Text(
                            "District".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  hintText: userData.data[0].userAddress1,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: greenColor,
              ),
            );
          }
        });
  }
}
