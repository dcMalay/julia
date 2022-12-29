import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/profile_details_model.dart';
import 'package:julia/data/repository/get_user_details_repo.dart';
import 'package:julia/provider/google_sign_in_provider.dart';
import 'package:julia/views/buybusiness/buy_business.dart';
import 'package:julia/views/help_support/helpsupport_webview.dart';
import 'package:julia/views/invoices/invoices_screen.dart';
import 'package:julia/views/my_account/components/edit_profile.dart';
import 'package:julia/views/my_account/components/new_user_screen.dart';
import 'package:julia/views/myads/myads.dart';
import 'package:julia/views/settings/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repository/create_ticket_repo.dart';
import '../../provider/auth_provider.dart';
import '../login_register/login.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var status;
  void isloggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      status = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  //Get from gallery
  XFile? image;
  late Future<Userdetails> getUserData;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final TextEditingController _createMessage = TextEditingController();
  void getUser() async {
    var authUser = await _secureStorage.read(key: 'userId');
  }

  @override
  void initState() {
    super.initState();

    isloggedIn();

    setState(() {
      getUserData = getUserDetails();
    });
    getUser();
    getUserData.then((value) {});
  }

  var _dropDownValue;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: status == true
          ? Scaffold(
              appBar: AppBar(
                elevation: 2,
                backgroundColor: greenColor,
                centerTitle: true,
                title: Text(
                  'profile'.tr(),
                  style: const TextStyle(color: Colors.white),
                ),
                actions: [
                  PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    context.setLocale(const Locale(
                                      'en',
                                    ));
                                  });
                                },
                                child: Text("english".tr())),
                            PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    context.setLocale(const Locale('nl'));
                                  });
                                },
                                child: Text("dutch".tr())),
                          ]),
                ],
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
                                child: Text("set_your_profile".tr()),
                                onPressed: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
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
                              onPressed: () {
                                authProvider.logout();
                                var provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider.logOut();

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
                                child: Text(
                                  "log_out".tr(),
                                  style: const TextStyle(
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
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: greenColor, width: 2)),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.grey,
                                  backgroundImage:
                                      NetworkImage(userData!.data[0].userImage),
                                ),
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
                                    style: TextStyle(
                                      color: greenColor,
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
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
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
                                icon: Icon(
                                  Icons.edit_note_outlined,
                                  size: 30,
                                  color: redColor,
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
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
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
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
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
                                children: [
                                  Icon(
                                    Icons.font_download_outlined,
                                    color: redColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'my_ads'.tr(),
                                    style: const TextStyle(
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
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const InVoicesScreen(),
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.receipt,
                                  color: greenColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'bought_packages'.tr(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        BuyBusiness(),
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_outlined,
                                  color: yellowColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'buy_buisness'.tr(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AlertDialog(
                                      title: Text('create_ticket'.tr()),
                                      content: TextFormField(
                                        controller: _createMessage,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 4,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            hintText: 'type_your_message'.tr()),
                                      ),
                                      actions: [
                                        InkWell(
                                          onTap: () async {
                                            if (_createMessage.text != '') {
                                              createTicket(_createMessage.text);
                                              _createMessage.clear();
                                              Navigator.pop(context);

                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.success,
                                                text:
                                                    'you_create_a_ticket'.tr(),
                                              );
                                            }
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(9),
                                              decoration: BoxDecoration(
                                                  color: greenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                'send_your_message'.tr(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.style_outlined,
                                  color: greenColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'ask_your_question'.tr(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(left: 50, right: 230),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _dropDownValue,
                              hint: Text('language'.tr()),
                              items: [
                                DropdownMenuItem<String>(
                                    value: 'en',
                                    child:
                                        SizedBox(child: Text('english'.tr()))),
                                DropdownMenuItem<String>(
                                    value: 'nl',
                                    child: SizedBox(child: Text('dutch'.tr()))),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  _dropDownValue = val;
                                  // ignore: deprecated_member_us
                                  if (val == 'en') {
                                    setState(() {
                                      context.setLocale(const Locale(
                                        'en',
                                      ));
                                    });
                                  } else if (val == 'nl') {
                                    setState(() {
                                      context.setLocale(const Locale('nl'));
                                    });
                                  }
                                });
                              },
                            ),
                          ),
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
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
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
                                Icon(
                                  Icons.settings_outlined,
                                  color: greenColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'settings'.tr(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'change_your_account_settings'.tr(),
                                      style: const TextStyle(
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
                              Icon(
                                Icons.help_outline_rounded,
                                color: greenColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const HelpandSupport(
                                                url:
                                                    'https://www.julia.sr/help.php'),
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
                                    child: Text(
                                      'help_support'.tr(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'get_help_with_account'.tr(),
                                    style: const TextStyle(
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
                              Icon(
                                Icons.logout_outlined,
                                color: redColor,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text("log_out".tr()),
                                      content: Text("want_to_log_out".tr()),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Center(
                                              child: Text(
                                                "no".tr(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final provider = Provider.of<
                                                    GoogleSignInProvider>(
                                                context,
                                                listen: false);

                                            provider.logOut();

                                            ///using phoenix to restart the app after log out
                                            // ignore: use_build_context_synchronously
                                            Phoenix.rebirth(context);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Center(
                                              child: Text(
                                                "yes".tr(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
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
                                  children: [
                                    Text(
                                      'log_out'.tr(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'log_out_your_profile'.tr(),
                                      style: const TextStyle(
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
            )
          : Center(
              child: CupertinoButton(
                  color: greenColor,
                  child: Text('register_first'.tr()),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
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
                      ),
                    );
                  }),
            ),
    );
  }
}
