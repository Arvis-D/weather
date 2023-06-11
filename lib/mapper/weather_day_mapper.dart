import '../model/weather_data_item.dart';
import '../model/weather_day.dart';

class WeatherDayMapper {
  static List<WeatherDay> mapToWeatherDays(List<WeatherDataItem> items) {
    List<WeatherDay> weatherDays = [];
    final DateTime nowUtc = DateTime.now().toUtc();
    DateTime dayStart = DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day, 1);

    while (true) {
      WeatherDay weatherDay = _getWeatherDay(dayStart, items);

      if (weatherDay.data.isEmpty) break;
      weatherDays.add(weatherDay);

      dayStart = nowUtc.add(const Duration(days: 1));
    }

    return weatherDays;
  }

  static WeatherDay _getWeatherDay(
      DateTime dayUtc, List<WeatherDataItem> items) {
    List<WeatherDataItem> itemsForDay = [];

    for (var item in items) {
      DateTime itemTime =
          DateTime.fromMillisecondsSinceEpoch(item.dateEpochSeconds * 1000);

      if (itemTime.day == dayUtc.day &&
          itemTime.month == dayUtc.month &&
          itemTime.year == dayUtc.year) {
        itemsForDay.add(item);
      }
    }

    return WeatherDay(itemsForDay, _getDayName(dayUtc));
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
