import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:julia/data/repository/get_user_details_repo.dart';
import 'package:julia/views/buybusiness/buy_business.dart';
import 'package:julia/views/my_account/components/edit_profile.dart';
import 'package:julia/views/my_account/components/new_user_screen.dart';
import 'package:julia/views/myads/myads.dart';
import 'package:julia/views/settings/setting_screen.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  //Get from gallery
  XFile? image;
  late Future<Userdetails> getUserData;
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final TextEditingController _emailController;
  late final TextEditingController _numberController;
  late final TextEditingController _stateController;
  late final TextEditingController _districtController;
  late final TextEditingController _areaController;

  void getUser() async {
    var authUser = await _secureStorage.read(key: 'userId');
    print('authUser ------>$authUser');
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      getUserData = getUserDetails();
    });
    getUser();
    getUserData.then(
      (value) => print("userid ------->>>${value.data[0].userId}"),
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: greenColor,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<Userdetails>(
            future: getUserData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: greenColor,
                  ),
                );
              }
              if (snapshot.data == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                          color: greenColor,
                          child: const Text("Set your profile"),
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const NewUserScreen(),
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
                            ));
                          }),
                      TextButton(
                        onPressed: () async {
                          await authProvider.logout();

                          ///using phoenix to restart the app after log out
                          // ignore: use_build_context_synchronously
                          Phoenix.rebirth(context);
                        },
                        child: Container(
                          height: 30,
                          width: 70,
                          padding: const EdgeInsets.only(
                            top: 6,
                            left: 8,
                          ),
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                Userdetails? userData = snapshot.data;
                return ListView(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 20,
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              'http://52.67.149.51/uploads/${userData!.data[0].userImage}'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 30,
                          top: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData.data[0].userName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              userData.user[0].userPhone,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 25,
                          left: 10,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const EditProfileScreen(),
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
                            ));
                          },
                          icon: const Icon(
                            Icons.edit_note_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const MyAdsScreen(),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const MyAdsScreen(),
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
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'My Ads',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  BuyBusiness(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 20),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.settings_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Buy Business',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 20),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.settings_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Bought Ticket',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 20),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.settings_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Review & Rating',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SettingScreen(),
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
                      child: Row(
                        children: [
                          const Icon(
                            Icons.settings_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Settings',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                ' change your account Settings',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.help_outline_rounded,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Help & Support',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              ' Get help with account',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Log Out"),
                                content: const Text(
                                    "Are you sure you want to logout?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 40,
                                      padding: const EdgeInsets.only(
                                        top: 6,
                                        left: 10,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await authProvider.logout();

                                      ///using phoenix to restart the app after log out
                                      // ignore: use_build_context_synchronously
                                      Phoenix.rebirth(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 40,
                                      padding: const EdgeInsets.only(
                                        top: 6,
                                        left: 8,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'logout your profile',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
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
