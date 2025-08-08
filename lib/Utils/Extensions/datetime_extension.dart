import 'package:flutter/foundation.dart';
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

extension DateTimeParsing on String? {

  DateTime? get toDateTime {
    if (this == null || this!.isEmpty) {
      return null;
    }

    try {
      DateTime parsedDate = DateTime.parse(this!);
      return parsedDate.toLocal(); // Convert to local timezone if needed
    } catch (e) {
      debugPrint("Error parsing DateTime: $e");
      return null; // Return null if parsing fails
    }
  }
}

extension DateTimeAgo on DateTime {
  String get timeAgo {
    final difference = DateTime.now().difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inSeconds > 0) {
      return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'second' : 'seconds'} ago';
    } else {
      return 'Just now';
    }
  }
}


