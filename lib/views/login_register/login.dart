import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:julia/helper/email_checker.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:julia/views/home.dart';
import 'package:julia/views/login_register/verify.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
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
        title: const Text(
          'Login',
          style: TextStyle(
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
                decoration: const InputDecoration(
                  labelText: "Enter Email",
                  border: OutlineInputBorder(),
                ),
                validator: (input) =>
                    input!.isValidEmail() ? null : "Check your email",
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
                      : const Text('Login'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Flushbar(
                      //   flushbarPosition: FlushbarPosition.TOP,
                      //   message: "Email send successfully",
                      //   duration: Duration(seconds: 3),
                      // ).show(context);
                      // showTopSnackBar(
                      //   context,
                      //   const CustomSnackBar.success(
                      //     message: 'Email send successfully',
                      //   ),
                      // );

                      //showDialog(context: context, builder:(context) => ,));
                      // QuickAlert.show(
                      //   context: context,
                      //   type: QuickAlertType.success,
                      //   text: 'Email send successfully',
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     duration: const Duration(seconds: 3),
                      //     behavior: SnackBarBehavior.floating,
                      //     backgroundColor: greenColor,
                      //     margin: EdgeInsets.only(
                      //         bottom: MediaQuery.of(context).size.height - 200,
                      //         right: 20,
                      //         left: 20),
                      //     // margin: const EdgeInsets.only(
                      //     //     top: 400, bottom: 400, left: 30, right: 30),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30)),
                      //     content: const Center(
                      //       child: Text(
                      //         'Email send successfully',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // );

                      Flushbar(
                        borderRadius: BorderRadius.circular(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        backgroundColor: yellowColor,
                        messageColor: Colors.black,
                        // titleText: Text(
                        //   "Great !",
                        // ),
                        flushbarPosition: FlushbarPosition.TOP,
                        messageSize: 20,
                        message: "Email send successfully",
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
                width: 250,
                child: CupertinoButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  color: const Color.fromARGB(255, 210, 210, 210),
                  // color: const Color.fromARGB(255, 191, 231, 190),
                  child: ListTile(
                      leading: Image.asset(
                        'assets/google.png',
                        height: 30,
                      ),
                      title: const Text(
                        'Continue with Google',
                        style: TextStyle(color: Colors.black),
                      )),
                  onPressed: () {},
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
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
            // Center(
            //   child: TextButton(
            //     onPressed: () {
            //       Navigator.of(context).push(
            //         PageRouteBuilder(
            //           pageBuilder: (context, animation, secondaryAnimation) =>
            //               const Registration(),
            //           transitionsBuilder:
            //               (context, animation, secondaryAnimation, child) {
            //             return SlideTransition(
            //               position: Tween<Offset>(
            //                       begin: const Offset(1, 0), end: Offset.zero)
            //                   .animate(animation),
            //               child: child,
            //             );
            //           },
            //         ),
            //       );
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         const Text(
            //           "Don't have a account?",
            //           style: TextStyle(
            //             fontSize: 16,
            //             color: Colors.black,
            //           ),
            //         ),
            //         Container(
            //           decoration: const BoxDecoration(
            //               border: Border(
            //                   bottom:
            //                       BorderSide(color: Colors.blue, width: 2))),
            //           child: const Text(
            //             "Register",
            //             style: TextStyle(
            //               fontSize: 16,
            //               color: Colors.blue,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
