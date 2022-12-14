import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julia/helper/email_checker.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:julia/views/login_register/login.dart';
import 'package:julia/views/login_register/verify.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late final TextEditingController _emailController;
  //late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    //  _passwordController = TextEditingController();
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
          'Registration',
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
            Center(
              child: CupertinoButton(
                  color: Colors.green,
                  child: authProvider.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Registration'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Email Send Successfully')),
                      );
                      authProvider.sentEmail(_emailController.text);
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  VerifyScreen(
                            email: _emailController.text,
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
                  }),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      PageRouteBuilder(
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
                      (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have a account?",
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
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
