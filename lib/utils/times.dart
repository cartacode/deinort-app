import 'package:intl/intl.dart';
import 'dart:async';

Future sleep() {
  return new Future.delayed(const Duration(seconds: 1), () => "1");
}

String readTimestamp(String created) {
  var now = new DateTime.now();
  var timestamp = DateTime.parse(created);
  var format = new DateFormat("HH:mm a");
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = 'heute - ' + format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = 'gestern - ' + format.format(date);
    } else {
      time = diff.inDays.toString() + ' DAYS AGO - ' + format.format(date);
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {

      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }

  return time;
}