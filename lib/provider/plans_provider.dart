import 'package:flutter/material.dart';
import 'package:julia/data/model/plans_model.dart';
import 'package:julia/data/repository/all_plans_repo.dart';

class PlanProider extends ChangeNotifier {
  List<Plans> planData = [];

  void getPlanData() async {
    planData = await getallPlans();
    notifyListeners();
  }
}
