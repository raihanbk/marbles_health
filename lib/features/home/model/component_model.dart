import 'package:flutter/material.dart';

class ComponentModel {
  TextEditingController labelController = TextEditingController();
  TextEditingController infoController = TextEditingController();

  List<Map<String, dynamic>> checkBox = [
    {'title': 'Required', 'isChecked': false},
    {'title': 'Read-only', 'isChecked': false},
    {'title': 'Hidden Field', 'isChecked': false}
  ];

}
