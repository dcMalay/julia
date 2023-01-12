import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:julia/const/const.dart';
import 'package:julia/data/model/verify_otp_model.dart';
import 'package:julia/provider/auth_provider.dart';
import 'package:julia/views/home.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.email});
  final String email;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  OtpTimerButtonController controller = OtpTimerButtonController();
  final _secureStorage = const FlutterSecureStorage();
  final TextEditingController _otpController = TextEditingController();

  Future verifyEmailOtp(String otp, String email) async {
    final url = '$baseUrl/user/getprofile/email/$email/$otp';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final userData = VerifyModel.fromJson(jsonResponse);
      await _secureStorage.write(key: 'token', value: userData.token);
      await _secureStorage.write(key: 'userId', value: userData.userId);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLoggedIn", true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Home(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
      ));
      return userData;
    } else if (response.statusCode == 400) {
      return;
    } else {
      throw Exception('getting error while otp verification');
    }
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  PinTheme? focusedPinTheme;
  PinTheme? submittedPinTheme;
  late int otp;
  @override
  void initState() {
    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          title: Text(
            'verify_your_account'.tr(),
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'enter_otp'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'enter_the_otp_sent_to_your_email_address'.tr(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Pinput(
              controller: _otpController,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              validator: (s) {},
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) {},
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: OtpTimerButton(
                controller: controller,
                backgroundColor: greenColor,
                onPressed: () {
                  authprovider.sentEmail(widget.email);
                  controller.startTimer();
                },
                text: Text('resend_otp'.tr()),
                duration: 60,
              ),
            ),
            SizedBox(
              height: 300.h,
            ),
            Center(
              child: Text(
                'all_personal_details'.tr(),
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Center(
                child: Text(
                  'terms_&_condition'.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                offset: Offset(-1, -4),
                spreadRadius: 0,
                blurRadius: 5,
                color: Colors.grey,
              )
            ]),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CupertinoButton(
              color: greenColor,
              child: Text("verify_otp".tr()),
              onPressed: () async {
                verifyEmailOtp(_otpController.text, widget.email);
              },
            )));
  }
}
