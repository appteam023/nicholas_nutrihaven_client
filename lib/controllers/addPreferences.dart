import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nicholas_nutrihaven/Config/AppRoutes/routes_imports.dart';
import 'package:nicholas_nutrihaven/Data/Repository/addPreferenceRepository.dart';

class AddpreferencesController extends GetxController {
  final Addpreferencerepository authRepository = Addpreferencerepository();
  String gender = "Male";

  int age = 28;
  int weight = 54;
  String weightUnit = "";

  String heighttUnit = "";

  int height = 3;
  String goal = "Lose Weight";
  String level = "Intermediate";

  String exercisePlace = "Large Gym";
  String exerciseEquipment = "";

  void addpreference(String id) async {
    try {
      var data = {
        "gender": gender,
        "age": age,
        "weight": weight,
        "weightUnit": "kg",
        "height": height,
        "heightUnit": "cm",
        "goal": goal,
        "level": "Intermediate",
        "exercisePlace": "67a4875c70574d6e2c5b3557",
        "exerciseEquipment": "67a477e67ecce5d2fe8b4285"
      };

      log(data.toString());

      var response = await authRepository.postPreference(data, id);

      if (response['success'] == true) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text("Preferences has been updated")));

        Get.offAllNamed(AppRoutes.bottomBar);
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(SnackBar(content: Text("Something went Wrong")));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
