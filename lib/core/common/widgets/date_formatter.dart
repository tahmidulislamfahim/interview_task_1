String formatDate(DateTime dateTime) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final wday = weekdays[dateTime.weekday - 1];
  final month = months[dateTime.month - 1];
  return "$wday, $month ${dateTime.day}";
}

String formatTime(DateTime dateTime) {
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  final period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  if (hour == 0) hour = 12;
  final minuteStr = minute < 10 ? '0$minute' : '$minute';
  return "$hour:$minuteStr $period";
}

String formatDayMonthYear(DateTime dt) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final monthStr = months[dt.month - 1];
  final yearStr = dt.year.toString().substring(2);
  return "${dt.day} $monthStr'$yearStr";
}

String getWeekdayName(DateTime dt) {
  const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  return weekdays[dt.weekday - 1];
}

