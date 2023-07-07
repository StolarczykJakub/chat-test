import 'package:intl/intl.dart';

extension IntExt on int {
  String formatTimestamp() {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);
    String formattedTime = DateFormat.Hm().format(dateTime);

    return formattedTime;
  }
}
