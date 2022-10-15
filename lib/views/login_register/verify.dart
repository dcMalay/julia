import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.phone, required this.otp});
  final String phone;
  final int otp;
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  OtpTimerButtonController controller = OtpTimerButtonController();

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
    otp = widget.otp;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Verify Your Account',
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Enter the OTP sent to your email address',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            validator: (s) {},
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: OtpTimerButton(
              controller: controller,
              backgroundColor: Colors.green,
              onPressed: () {},
              text: const Text('Resend OTP'),
              duration: 60,
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
          color: Colors.green,
          child: const Text('Verify'),
          onPressed: () {},
        ),
      ),
    );
  }
}
