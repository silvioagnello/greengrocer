import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UtilsService {
  final storage = const FlutterSecureStorage();
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime.toLocal());
  }

  Uint8List decodeQrCodeImage(String value) {
    String base64String = value.split(',').last;
    return base64.decode(base64String);
  }

  void myToast(
      {required String msg, bool isError = false, BuildContext? context}) {
    Fluttertoast.showToast(
      // showToast(
      //     context: context,
      // textStyle: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     color: isError ? Colors.white : Colors.black),
      textColor: isError ? Colors.white : Colors.black,
      // position: StyledToastPosition.center,
      gravity: ToastGravity.CENTER,
      backgroundColor:
          isError ? Colors.red.shade300 : Colors.cyanAccent.shade100,
      // duration: const Duration(seconds: 2),
      msg: msg,
    );
  }
}
