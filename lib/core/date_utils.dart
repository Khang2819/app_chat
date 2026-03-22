class DateHelper {
  static bool isToday(DateTime? date) {
    if (date == null) return false;

    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
