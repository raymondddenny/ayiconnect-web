import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpServices {
  static String lat = '';
  static String long = '';

  static String url = "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$long";
  static Future<String> getCityAndCountry() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        final String formatCityAndCountry = jsonResponse['city'] + ', ' + jsonResponse['countryName'];
        return formatCityAndCountry;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
