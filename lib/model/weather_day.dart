import 'package:weather/model/weather_data_item.dart';

class WeatherDay {
  List<WeatherDataItem> data;
  String dayName;

  WeatherDay(this.data, this.dayName);
}
