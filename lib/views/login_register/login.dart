import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julia/helper/email_checker.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:julia/views/login_register/registration.dart';
import 'package:julia/views/login_register/verify.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //bool _isObscure = true;
  late final TextEditingController _emailController;
  // late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    // _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController = TextEditingController();
    // _passwordController = TextEditingController();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Enter Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (input) =>
                      input!.isValidEmail() ? null : "Check your email",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: TextField(
              //     controller: _passwordController,
              //     obscureText: _isObscure,
              //     decoration: InputDecoration(
              //       labelText: "Password",
              //       border: const OutlineInputBorder(),
              //       suffixIcon: IconButton(
              //         onPressed: () {
              //           setState(() {
              //             _isObscure = !_isObscure;
              //           });
              //         },
              //         icon: Icon(
              //           _isObscure
              //               ? Icons.visibility_off
              //               : Icons.visibility,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: CupertinoButton(
                  color: Colors.green,
                  child: authProvider.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Login'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Email Send Successfully')),
                      );
                      authProvider.sentEmail(_emailController.text);
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const VerifyScreen(
                            otp: 120390,
                          ),
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
                    }
                    // // ignore: use_build_context_synchronously
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: const Text('Email send successfully'),
                    //     behavior: SnackBarBehavior.floating,
                    //     backgroundColor: Colors.green,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     margin: EdgeInsets.only(
                    //       bottom:
                    //           // ignore: use_build_context_synchronously
                    //           MediaQuery.of(context).size.height - 150,
                    //       right: 20,
                    //       left: 20,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Registration(),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have a account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.blue, width: 2))),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
