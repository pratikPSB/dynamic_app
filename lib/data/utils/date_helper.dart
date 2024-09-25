import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  //Date Formator
  static const dfyyyymmdd = "yyyy-MM-dd";
  static const dfddmmmyyyy = "dd-MMM-yyyy";
  static const dfddmmyyyy = "dd/MM/yyyy";
  static const dfmmddyyyy = "MM/dd/yyyy";

  static const dfddmmyyyyHMS = "dd/MM/yyyy h:mm a";
  static const dfddmmmyyyyHMA = "dd-MMM-yyyy h:mm a";
  static const dfddmmmyyyyNHMA = "dd-MMM-yyyy \nh:mm a";

  static const dfdmyhms = "yyyy-MM-dd hh:mm:ss";
  static const dfhhmmss = "hh:mm:ss";
  static const dfhhmmsss = "hh:mm:ss.s";
  static const dfhhmm = "HH:mm";
  static const dfhhmma = "h:mm a";
  static const dfmmm = "MMM";
  static const dfyyyymmddThhmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
  static const dfyyyymmddhhmmssSSSZ = "yyyy-MM-dd HH:mm:ss.SSSZ";

  static int getCurrentDay() {
    DateTime now = DateTime.now();
    return now.day;
  }

  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  static int getCurrentYear() {
    DateTime now = DateTime.now();
    return now.year;
  }

  static DateTime convertStringDate(String strCurrentFormate, String strDate) {
    return DateFormat(strCurrentFormate).parse(strDate);
  }

  static String convertDateString(
      String strDate, String strCurrentFormate, String strExpectedFormate) {
    if (strDate.isEmpty || strDate == "0.00") {
      return strDate;
    } else {
      DateTime parseDate = DateFormat(strCurrentFormate).parse(strDate);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(strExpectedFormate);
      var outputDate = outputFormat.format(inputDate);

      return outputDate;
    }
  }

  static Future<DateTime?> commonPickedDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? getCurrentDate(),
      firstDate: firstDate ?? DateTime(DateHelper.getCurrentYear() - 50),
      lastDate: lastDate ?? DateTime(DateHelper.getCurrentYear() + 50),
      cancelText: "Close",
      confirmText: "OK",
      builder: (context, child) {
        return child!;
      },
    );
  }

  static String formattedDate(String date) {
    // Implement your date formatting logic
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  static bool isDateInRange(String date, String fromDate, String toDate) {
    final parsedDate = DateTime.parse(formattedDate(date));
    final parsedFromDate = DateTime.parse(fromDate);
    final parsedToDate = DateTime.parse(toDate);
    return (parsedDate.isAtSameMomentAs(parsedFromDate) ||
        parsedDate.isAtSameMomentAs(parsedToDate) ||
        (parsedDate.isAfter(parsedFromDate) && parsedDate.isBefore(parsedToDate)));
  }
}
