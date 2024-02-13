import 'package:flutter/material.dart';
// import 'package:intl/src/intl/date_format.dart';
import 'package:intl/intl.dart';
import 'package:vavavoum/app/modules/home/controllers/home_controller.dart';

Future<void> selectDate(HomeController controller, BuildContext context) async {
  
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101));
  if (picked != null && picked != DateTime.now()) { controller.dateDepart.value.text = DateFormat('dd-MM-yyyy').format(picked).toString();
  }
}

Future<void> selectDate2(HomeController controller, BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101));
  if (picked != null && picked != DateTime.now()) { controller.dateRetours.value.text = DateFormat('dd-MM-yyyy').format(picked).toString();
  }
}