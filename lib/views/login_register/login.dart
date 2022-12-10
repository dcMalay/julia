import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:julia/helper/email_checker.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:julia/provider/google_sign_in_provider.dart';
import 'package:julia/views/home.dart';
import 'package:julia/views/login_register/verify.dart';
import 'package:provider/provider.dart';
import '../../const/const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController = TextEditingController();
    super.dispose();
  }

  var _dropDownValue;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: greenColor,
        leading: IconButton(
          onPressed: () {
            Phoenix.rebirth(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "login".tr(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: DropdownButton(
                borderRadius: BorderRadius.circular(6),
                value: _dropDownValue,
                hint: Text('language'.tr()),
                items: [
                  DropdownMenuItem<String>(
                      value: 'en', child: Text('english'.tr())),
                  DropdownMenuItem<String>(
                      value: 'nl', child: Text('dutch'.tr())),
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
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                    'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "enter_email".tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (input) =>
                    input!.isValidEmail() ? null : "check_your_email".tr(),
                onChanged: (value) => _formKey.currentState!.validate(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: 250,
                height: 56,
                child: CupertinoButton(
                  color: greenColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: authProvider.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "login".tr(),
                        ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Flushbar(
                        borderRadius: BorderRadius.circular(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        backgroundColor: yellowColor,
                        messageColor: Colors.black,
                        flushbarPosition: FlushbarPosition.TOP,
                        messageSize: 20,
                        message: "email_send_successfully".tr(),
                      ).show(context);
                      authProvider.sentEmail(_emailController.text);

                      Timer(const Duration(seconds: 2), () {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    VerifyScreen(
                              email: _emailController.text,
                            ),
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
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: 280,
                child: CupertinoButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  color: const Color.fromARGB(255, 210, 210, 210),
                  child: ListTile(
                      leading: Image.asset(
                        'assets/google.png',
                        height: 30,
                      ),
                      title: Text(
                        'continue_with_google'.tr(),
                        style: const TextStyle(color: Colors.black),
                      )),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);

                    provider.googleLogin(context);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Home(),
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
                  },
                  child: Text(
                    'skip'.tr(),
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
