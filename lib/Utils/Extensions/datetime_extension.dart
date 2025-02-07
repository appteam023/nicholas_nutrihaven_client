import 'package:intl/intl.dart';

String DateFormator(DateTime date) {
  final f = new DateFormat('MM-dd-yyyy').format(date);
  return f.toString();
}

String StringToDate(String date) {
  DateTime dt = DateTime.parse(date);
  final f = new DateFormat('MM-dd-yyyy').format(dt);
  print(f);
  return f.toString();
}

String StringToDateTime(String date) {
  DateTime dt = DateTime.parse(date);
  final f = new DateFormat('MM-dd-yyyy hh:mm aa').format(dt);
  print(f);
  return f.toString();
}

String StringToTime(String date) {
  DateTime dt = DateTime.parse(date);
  final f = new DateFormat('hh:mm aa').format(dt);
  print(f);
  return f.toString();
}

String TimeFormatter(String date) {
  DateTime dt = DateTime.parse(date);
  final f = DateTime.now().difference(dt);
  var days = f.inDays;
  print(days);
  if (days > 31) {
    return "${(days ~/ 30).toString()} months ago";
  } else if (days > 256) {
    return "${(days ~/ 12).toString()} years ago";
  } else if (days <= 0) {
    if (f.inHours <= 0) {
      if (f.inMinutes <= 0) {
        return "${f.inSeconds.toString()} seconds ago";
      }
      return "${f.inMinutes.toString()} mins ago";
    } else {
      return "${f.inHours.toString()} hours ago";
    }
  } else if (days == 1) {
    return "${days.toString()} day ago";
  } else {
    return "${days.toString()} days ago";
  }
}
