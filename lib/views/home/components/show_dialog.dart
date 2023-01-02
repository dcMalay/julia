import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../const/const.dart';
import '../../my_account/components/new_user_edit_screen.dart';

class ShowDialogWidget extends StatefulWidget {
  const ShowDialogWidget({super.key});

  @override
  State<ShowDialogWidget> createState() => _ShowDialogWidgetState();
}

class _ShowDialogWidgetState extends State<ShowDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        "set_your_profile".tr(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      actions: [
        CupertinoButton(
            color: greenColor,
            child: Text('next'.tr()),
            onPressed: () {
              Navigator.of(context).pushReplacement(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const NewUserEditScreen(
                  isHome: false,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(1, 0), end: Offset.zero)
                        .animate(animation),
                    child: child,
                  );
                },
              ));
            }),
      ],
    );
    ;
  }
}
