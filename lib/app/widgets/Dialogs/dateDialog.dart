import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vavavoom/app/modules/home/controllers/home_controller.dart';

Future<void> selectDate(HomeController controller, BuildContext context) async {
  
  final DateTime? picked = await showDatePicker(
      context: context,
      cancelText: "Annuler",
      // locale : const Locale("fr","FR"),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
  if (picked != null && picked != DateTime.now()) { controller.dateDepart.value.text = DateFormat('dd-MM-yyyy').format(picked).toString();
  }
}

Future<void> selectDate2(HomeController controller, BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      // locale: const Locale("fr", "FR"),
      cancelText: "Annuler",
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
  if (picked != null && picked != DateTime.now()) { controller.dateRetours.value.text = DateFormat('dd-MM-yyyy').format(picked).toString();
  }
}
// https://www.buymeacoffee.com/modernweb/e/171824