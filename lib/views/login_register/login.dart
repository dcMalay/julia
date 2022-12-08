import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:julia/helper/email_checker.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:julia/provider/google_sign_in_provider.dart';
import 'package:julia/views/home.dart';
import 'package:julia/views/login_register/verify.dart';
import 'package:provider/provider.dart';
import '../../const/const.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Hello World',
    },
    'es': {
      'title': 'Hola Mundo',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      DemoLocalizations.languages().contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}

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
          DemoLocalizations.of(context).title,
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
                hint: const Text('Language'),
                items: const [
                  DropdownMenuItem<String>(value: 'en', child: Text('English')),
                  DropdownMenuItem<String>(value: 'nl', child: Text('Dutch')),
                ],
                onChanged: (val) {
                  setState(() {
                    _dropDownValue = val;
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
                      Flushbar(
                        borderRadius: BorderRadius.circular(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        backgroundColor: yellowColor,
                        messageColor: Colors.black,
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
                  child: ListTile(
                      leading: Image.asset(
                        'assets/google.png',
                        height: 30,
                      ),
                      title: const Text(
                        'Continue with Google',
                        style: TextStyle(color: Colors.black),
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
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
