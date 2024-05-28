import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UtilsService {
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  void myToast(
      {required String msg,
      bool isError = false,
      required BuildContext context}) {
    showToast(
        context: context,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: isError ? Colors.white : Colors.black),
        position: StyledToastPosition.center,
        backgroundColor:
            isError ? Colors.red.shade300 : Colors.cyanAccent.shade100,
        duration: const Duration(seconds: 2),
        msg);
  }
}
