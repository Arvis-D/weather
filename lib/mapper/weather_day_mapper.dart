import '../model/local/weather_day.dart';
import '../model/shared/weather_data_item.dart';

class WeatherDayMapper {
  static List<WeatherDay> fromWeatherDataItems(List<WeatherDataItem> items) {
    List<WeatherDay> weatherDays = [];
    if (items.isEmpty) return weatherDays;
    items.sort((a, b) => a.dateEpochSeconds.compareTo(b.dateEpochSeconds));

    DateTime initialDayTime = DateTime.fromMillisecondsSinceEpoch(
      items.first.dateEpochSeconds * 1000,
    );
    List<WeatherDataItem> itemsForDay = [];

    for (WeatherDataItem item in items) {
      DateTime itemTime = DateTime.fromMillisecondsSinceEpoch(
        item.dateEpochSeconds * 1000,
      );

      if (!_sameDay(initialDayTime, itemTime)) {
        weatherDays.add(WeatherDay(itemsForDay, _getDayName(initialDayTime)));

        initialDayTime = itemTime;
        itemsForDay = [];
      }

      itemsForDay.add(item);
    }

    return weatherDays;
  }

  static bool _sameDay(DateTime time1, DateTime time2) {
    return time1.day == time2.day &&
        time1.month == time2.month &&
        time1.year == time2.year;
  }

  static String _getDayName(DateTime day) {
    String dayName = "Invalid";
    if (day.weekday == DateTime.monday) {
      dayName = "Monday";
    } else if (day.weekday == DateTime.tuesday) {
      dayName = "Tuesday";
    } else if (day.weekday == DateTime.wednesday) {
      dayName = "Wednesday";
    } else if (day.weekday == DateTime.thursday) {
      dayName = "Thursday";
    } else if (day.weekday == DateTime.friday) {
      dayName = "Friday";
    } else if (day.weekday == DateTime.saturday) {
      dayName = "Saturday";
    } else if (day.weekday == DateTime.sunday) {
      dayName = "Sunday";
    }
    return dayName;
  }
}
