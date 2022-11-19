import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:julia/data/model/last_message_model.dart';

import '../data/repository/get_last_message_repo.dart';

class GetLastMessage extends ChangeNotifier {
  late List<Lastmessage> messageData;
  List<String> messageId = [];
  void getlstmsg() async {
    try {
      messageData = await getlastmessage();
      messageId.add(messageData[0].id!);
      debugPrint(messageId.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
