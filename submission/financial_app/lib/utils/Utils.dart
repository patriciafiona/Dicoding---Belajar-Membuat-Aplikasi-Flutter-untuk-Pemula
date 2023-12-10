import 'package:intl/intl.dart';

String returnCurrentMonth() {
  var currentDateTime = DateTime.now();
  return DateFormat.MMMM().format(currentDateTime);
}