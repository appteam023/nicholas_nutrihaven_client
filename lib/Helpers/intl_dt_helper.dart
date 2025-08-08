import 'package:intl/intl.dart';

String DateFormator(DateTime date) {
  final f = DateFormat('MM-dd-yyyy').format(date);
  return f.toString();
}

String StringToDate(String date) {
  DateTime dt = DateTime.parse(date);
  final f = DateFormat('dd').format(dt);
  print(f);
  return f.toString();
}

String StringToDateTime(String date) {
  DateTime dt = DateTime.parse(date);
  final f = DateFormat('MM-dd-yyyy hh:mm aa').format(dt);
  print(f);
  return f.toString();
}

String StringToTime(String date) {
  DateTime dt = DateTime.parse(date);
  final f = DateFormat('hh:mm aa').format(dt);
  print(f);
  return f.toString();
}

String DateToDays(String date) {
  DateTime dt = DateTime.parse(date);
  final f = DateTime.now().difference(dt);
  return f.inDays.toString();
}

String StringToDob(String date) {
  DateTime dt = DateTime.parse(date);
  final f = DateFormat('MM-dd-yyyy').format(dt);
  print(f);
  return f.toString();
}
