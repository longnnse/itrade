import 'package:intl/intl.dart';

extension FormatDateTime on DateTime{
  String format(String formatter){
    return DateFormat(formatter).format(this);
  }
}