import '/services/location.dart';
import '/services/networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = new NetworkHelper(
      url: Uri.http(
        "api.openweathermap.org",
        "/data/2.5/weather",
        {
          'q': '$cityName',
          'appid': 'ecb702f1fff242760c2113b06e645630',
          'units': 'metric'
        },
      ),
    );

    var decodedData = await networkHelper.getData();
    return decodedData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentPosition();
    NetworkHelper networkHelper = new NetworkHelper(
      url: Uri.http(
        "api.openweathermap.org",
        "/data/2.5/weather",
        {
          'lat': '${location.latitude}',
          'lon': '${location.longitude}',
          'appid': 'ecb702f1fff242760c2113b06e645630',
          'units': 'metric'
        },
      ),
    );

    var decodedData = await networkHelper.getData();
    return decodedData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
