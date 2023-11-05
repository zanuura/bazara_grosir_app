import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String currText({String? text}) {
  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.');
  String formated = formatCurrency.format(int.parse(text.toString()));

  return formated;
}
